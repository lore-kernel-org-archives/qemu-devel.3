Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1224CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiF1-0005m6-MM; Tue, 28 Oct 2025 07:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDiEz-0005lh-Nf
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:51:53 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDiEx-0007av-A2
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:51:53 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-61feb87fe26so10013669a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761652305; x=1762257105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=if4SeftyPY4YOGFs06B2Ms4qhDTlHia+6cs4AEOESkg=;
 b=yrEJto473S7YTvAm3kIciIeuP7F3tZ/6EBwMIA2M5C31C2kw5h/coCNQ4fskwVkunh
 VYUoo9SqLR1Cw9JI6wmQ6IqgcBOftr0DCwvKIZTGJ6PToTj3vDzRUjAMZj402hUgrLD4
 1ressutk0/0xQL6DI5GuRowQpevvh0TrTTtlr5ouykHgUygo183uKpolcmzcgGegqxNk
 12C1Q5b48m7dsHtJKb9CMAbEQ/+vi6uWCIVSVOR03F0sUbxO4h6xUqJoeSxKBdFCRawy
 SoSVnmpUbDrrv57ju9fbeU3B+4kgMRKgIUgXbLb+lJ2eHw1tHzm9by+rXvabj1Yrf7mg
 Fh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761652305; x=1762257105;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=if4SeftyPY4YOGFs06B2Ms4qhDTlHia+6cs4AEOESkg=;
 b=tpmqPrppyBHbyjoedfQmafj8nP+lM8WADaMU0s1xddJv8cbH8otH4Qj8n5PYVqH+5D
 KqjZG2rTrbhnSRu6A1rQI0K9nR70WzKkz9uA5z1Nr/dQnJgGxXFP09CXrLKv7A+4N0rT
 FO38GMhh9+oI3gmmWnbUVNXbDbohGO9xUopE6IgI6OsomG2um++Rqy9e42dyFbUETfpz
 VPGjVIR/g65kqmbYnUKAt9HGkMmhLk+iFWp9dMPujjdCFVA7qqJfA4f4J3yDxHJXxoQP
 9c8lHIdQoy5Hhee/OLvfC6aDIFERpZsZxW14wJ77o1uOWbQlkeGVuSOf8HlK+Qd5v+AF
 CBeA==
X-Gm-Message-State: AOJu0YxjKBqmCFJ7ATiEQwqCtMcSx+pg6RK2LsRAGd5xfQJaW62VLII9
 z7sMdwylA9OFfoEc7vHGdWQUQpkowgMqc34KEarKQSr2TV8V9n08vx3Uq4q61tPij9s=
X-Gm-Gg: ASbGncuUzGWLu/9+MSPKNJtypq05aVISa7fkLRt/sv5ch0wAxvgDeJ4ay42EyIkz6Sw
 BAQdiayr5cvNHPf/RsX5BmXZx0+zQoOS6K4q/z0q0rhkWNlJCNfFRiRtYuKEU58tMxHC1GRJYMU
 g8zJVzBjMRfUuzuu508lT7U/BJJIJMihLfR+v+pjNHKt/QfYKA7YuBrxl6Nyu9e2RNi/G1mMIhL
 oaQmqyKWQNFD65XjH6thMxumZxDDZVFjlqSjgPEgD84xjawGArESdgrv4cOAj8x4/xMxjnjDndD
 d6Z2negCzHuhIxVJdOk9QBznAbXX8UDz5G4RUbSnYsY6GVD5XoB1Aa+vQPS92fuZGOemISLn1cu
 6SUAtS34ShxOnHSk7LRGPDVrMIRp8VCRNY1MDY0Pvh32v6AH4OSh7tlMHCzIpuLvww2Q6Kw4BHi
 4VbFlWAEp8mVA=
X-Google-Smtp-Source: AGHT+IGGFPuw9R4e2NpovDPbpMeSOBWQ5Acn6TGo+wd8txJFtLeyqYvll/fEP+mmi/hEAYE+Wn/+PA==
X-Received: by 2002:a17:907:847:b0:b07:c1df:875 with SMTP id
 a640c23a62f3a-b6dba58b628mr376462166b.56.1761652304813; 
 Tue, 28 Oct 2025 04:51:44 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85398444sm1063914666b.35.2025.10.28.04.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 04:51:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B43D75F828;
 Tue, 28 Oct 2025 11:51:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Mads Ynddal <mads@ynddal.dk>,  Cameron Esfahani
 <dirty@apple.com>,  qemu-arm@nongnu.org,  Roman Bolshakov
 <rbolshakov@ddn.com>,  Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Phil
 Dennis-Jordan <phil@philjordan.eu>,  Mohamed Mediouni
 <mohamed@unpredictable.fr>,  Peter Collingbourne <pcc@google.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 42/59] accel/hvf: Skip WFI if CPU has work to do
In-Reply-To: <20251028054238.14949-43-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 28 Oct 2025 06:42:18
 +0100")
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-43-philmd@linaro.org>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Tue, 28 Oct 2025 11:51:42 +0000
Message-ID: <878qgvxn01.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Avoid sleeping vCPU thread for any pending work, not just IRQs.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

