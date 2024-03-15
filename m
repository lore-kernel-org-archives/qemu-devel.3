Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FCEC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5RM-0008JY-65; Fri, 15 Mar 2024 07:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rl5RJ-0008Gg-C4
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:09:29 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rl5RH-0006MD-Ha
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:09:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-413ef770363so15358785e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 04:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710500964; x=1711105764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04OJfbSzWusN/VZpxRtEm0O003DJV5Le58rCeQlCex4=;
 b=DEjTUMZdUzfZFSxa41X6STf/BfJcJGsxav8KVy3a9ZxCcQtxGvqlU2i941FECOQ20u
 QH4ZM3dWDUA+ls04tyOW79CRrwkYUeSiam2jNO92W7Jznrn8G8jNI9NQHMrvUMou8Aes
 Jd4RLB1nu7XS+4b5u1TNZYWw6HsfgVHW4Grp+9qtX4vLUVTW4yuhmVX4zliYOxc+Jwyj
 tndxCOSum24qqIWs1xg3DY0w8+wFSSLsYcmx+fh1Z5LMEmubpvtLQNOOi4ubrRxyW+sw
 7IizR/DNy/YvMe8t9RKlPf0pdiF0ztph4UsbFyWB/e5057CpIn7LhD90PRh92/QqG/Av
 ujfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710500964; x=1711105764;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=04OJfbSzWusN/VZpxRtEm0O003DJV5Le58rCeQlCex4=;
 b=prXrY58IhOXADDSfWhKyE27aYADoFXxvZK4v92X90aJH3bTT5rmgqsY7sdgVp1D11/
 Ell2+WY4mduoECxMtD9aPLLbW8n3bX+JTtGEgT6m5yGW5h6FwvISEHTVeXB8g9XmbMnH
 HjcU6AelYYdwTmuinNcOI1ElmqchjgbY14pU+IWCnGX6X8pcYaTlqk59u1ktVvgWKnMy
 yQFVotSwyj7RPfVQ5tLBie34yBG0c8yDhh7RD2Q/3G1fohuUD+hnp4eAnuTTH+Sbc2P7
 4vDmgtEqBy2xyxmuF+YJRTkUdWtMlUfnEk+EMu/2mdL9ofyEQUPBula3VsNHGhQfaiP3
 rVQg==
X-Gm-Message-State: AOJu0YyVY7PfRAgoMtQEuPF3ebTSAlc1D6KKP5McJeOfLXT/YoLBMDel
 ZBQHvLTEXCcL8R2YpSch5vV19hlJcDLJEqS8NjG02ls9hFCobWMfQdj9sZnZykw=
X-Google-Smtp-Source: AGHT+IGi52eUG/qE+zqVWJfrBd1aVsUCI24myzC8wu1h+WF2ZSxot2tqbAsk6pxxUqwLS1KNf0NEuQ==
X-Received: by 2002:a05:600c:4450:b0:413:f1c5:4b1b with SMTP id
 v16-20020a05600c445000b00413f1c54b1bmr2502601wmn.33.1710500964255; 
 Fri, 15 Mar 2024 04:09:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fj6-20020a05600c0c8600b00414024b2f49sm1238606wmb.0.2024.03.15.04.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 04:09:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 945025F785;
 Fri, 15 Mar 2024 11:09:23 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Burton <mburton@qti.qualcomm.com>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Alistair Francis <alistair.francis@wdc.com>,  Bin
 Meng <bin.meng@windriver.com>,  Edgar E. Iglesias
 <edgar.iglesias@gmail.com>,  Stefano Stabellini <sstabellini@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Don Harbin
 <don.harbin@linaro.org>,  Alessandro Di Federico <ale@rev.ng>,  Anton
 Johansson <anjo@rev.ng>,  =?utf-8?Q?Fran=C3=A7ois?= Ozog
 <ff@shokubai.tech>,  Song Gao
 <gaosong@loongson.cn>,  Michael Rolnik <mrolnik@gmail.com>,  Brian Cain
 <bcain@quicinc.com>,  Christoph Muellner <christoph.muellner@vrull.eu>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,  Max Filippov
 <jcmvbkbc@gmail.com>,  Francisco Iglesias <francisco.iglesias@amd.com>
Subject: Re: Any interest in the QEMU community attending DVCon Europe
 October 2024?
In-Reply-To: <8734t4wuco.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Tue, 05 Mar 2024 15:50:47 +0000")
References: <8734t4wuco.fsf@draig.linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.2
Date: Fri, 15 Mar 2024 11:09:23 +0000
Message-ID: <871q8b4uqk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> Over recent years there has been a push to make QEMU more flexible for
> EDA type applications. As long time developers know there are a number
> of downstream forks of QEMU which have their own solutions for modelling
> heterogeneous systems and integrating with hardware models. The work by
> Philippe, Anton and others to build a single binary with composable
> hardware is aiming at least to solve the heterogeneous modelling problem
> in the upstream project.
>
> While we do discuss these "TCG" topics during KVM Forum the project may
> benefit from doing some outreach at some conferences where simulation
> and emulation are the primary focus.
>
> The Design and Verification Conference & Exhibition Europe (DVCon
> Europe) is the premier European technical conference on system,
> software, design, verification, validation and integration. This year it
> will be on the 15-16 October 2024 in Munich. See: https://dvcon-europe.or=
g/
>
> There have been a number of papers and workshops on QEMU/KVM topics over
> the years. Unfortunately the website doesn't provide slides or videos of
> the talks but topics have included how QEMU can be used as a fast
> instruction simulator alongside things such as SystemC models or
> virtualisation can be leveraged to accelerate full system emulation.
>
> The main tracks are fairly academic where engineering and research
> papers are submitted and if accepted can then be presented at the
> conference. This is probably over the top for QEMU related stuff but
> their is a tutorial track (deadline for Abstracts 1st July) which could
> be a good target for a introduction to the features and capabilities of
> the QEMU upstream. I suspect there would be interest in the wider
> modelling community to find out more about how to use the upstream
> project directly.
>
> There is a co-located "SystemC Evolution Day" on the 17th where there
> might well be a strong overlap between SystemC users and QEMU. Mark
> Burton is involved with that and is keen for proposals talking about
> integrating SystemC models with QEMU. Please send a message to
> mburton@quicinc.com if you're interested.
>
> So is anyone interested?
>
> Should we do more within the community to network and discuss our plans
> for QEMU as a modelling solution?
>
> Any other thoughts?

Gentle ping, any interest?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

