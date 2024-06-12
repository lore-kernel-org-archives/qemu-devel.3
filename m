Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8675C27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 19:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHTn5-0003BZ-Ii; Wed, 12 Jun 2024 15:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHTn4-0003Ak-Dh
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:37:50 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHTmw-0007Il-4c
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:37:50 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63a96so137866a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718221060; x=1718825860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IAjYSIJy3iUmCe4piphWkEv6nCY066xAzP9Cs/eLYu8=;
 b=Gr0FB5d/v9N26FA/fUebZVQRSTmFBIFAsEvAWUdBwfgTzHZG5LHTRniOKHiYIjZDMK
 pidoe6TXtyND3OFaquduKl9aVDIkYPrAJrkoHOHIK+ShY1Bk1eMVqOF4r0+8FlkJBqjW
 +Uen86ypBiEKk2Uc1y5Sf8lFZQhcMLCVBEDbauCsBgp6kIzKijWBVzOAiag1qYVVMOPl
 0FhwbbSKS66Z+imFHOHA/MtVpNiygTHnL/Y3ODBQ4gy3H9dc4gpjFNR5QCVYsvccm3eB
 iBnrPwKetBOZP+V3RdhwvkxZK+WNWS8otKa/h4dUexEyOe4me6/pdOXtbMJTKShXT0qI
 gxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718221060; x=1718825860;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAjYSIJy3iUmCe4piphWkEv6nCY066xAzP9Cs/eLYu8=;
 b=q9m7SttBJod443T2oK60GoVVPd9CiE/o2cu6x4AZDEq//pPmnvcEypYp8akxqMKnA/
 hXSqofCScdEr9pJQWrYYaPFDiCWuAc5/x7lb8/GS+d12CqnsjGmDkYnByCIEvBxRc4iy
 VCpgGlLogjtqTpTRa6aCGaN/wYYbewwKHIVfOnra4xLuiIm99vT5E8TfKWkfIJwMP5Hk
 tBtJ9NukJiqwa7tEsIZc5ewqXBah1KRhSie4JbKezxZ62XqsCyF1ijNx5Pea1wM1AQaX
 zOcUk7m3Vb68Ejf0CZhTGdrvFdfaMR8LgkxYZuxBO1LAMeXqnfMU9vtotdBG2+9vPZM6
 P3Wg==
X-Gm-Message-State: AOJu0YyYTr1QwfBUmc+Y2dugahZK1cKvxmdkMe66abidKjetnfOFUxPU
 lbExBHvJivY7AxZxfbcKMia9CQrFwRM6AMGRBD7QDzLVNVIbVdr9O6Shb+XYy9I=
X-Google-Smtp-Source: AGHT+IHSHF+J9LXbsSxNNhuSucQZPz9yQEv/C3Lxowmc20Y1tTB/+h0HyatGxfAnTBj1AYdb9LL1cA==
X-Received: by 2002:a50:cd9e:0:b0:57c:a7dc:b121 with SMTP id
 4fb4d7f45d1cf-57caa9bace7mr1795582a12.34.1718221060693; 
 Wed, 12 Jun 2024 12:37:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c92901b05sm3656071a12.73.2024.06.12.12.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 12:37:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E44EA5F893;
 Wed, 12 Jun 2024 20:37:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  David Hildenbrand <david@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Marcelo Tosatti <mtosatti@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Mark Burton <mburton@qti.qualcomm.com>,
 qemu-s390x@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org,  Laurent Vivier <lvivier@redhat.com>,  Halil Pasic
 <pasic@linux.ibm.com>,  Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  qemu-arm@nongnu.org,  Alexander
 Graf <agraf@csgraf.de>,  Nicholas Piggin <npiggin@gmail.com>,  Marco
 Liebel <mliebel@qti.qualcomm.com>,  Thomas Huth <thuth@redhat.com>,  Roman
 Bolshakov <rbolshakov@ddn.com>,  qemu-ppc@nongnu.org,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Cameron Esfahani <dirty@apple.com>,  Jamie Iles
 <quic_jiles@quicinc.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 8/9] plugins: add time control API
In-Reply-To: <abe88b9b-621a-4956-877d-dd311a7fd58b@linaro.org> (Pierrick
 Bouvier's message of "Wed, 12 Jun 2024 08:56:12 -0700")
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-9-alex.bennee@linaro.org>
 <abe88b9b-621a-4956-877d-dd311a7fd58b@linaro.org>
Date: Wed, 12 Jun 2024 20:37:39 +0100
Message-ID: <87ikyevtoc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Hi Alex,
>
> I noticed the new symbols lack QEMU_PLUGIN_API qualifier in
> include/qemu/qemu-plugin.h:
> - qemu_plugin_update_ns
> - qemu_plugin_request_time_control
>
> So it would be impossible to use those symbols on windows.
>
> I kept a reminder to send a new patch after you pulled this, but if we
> go to a new series, it could be as fast for you to just add this
> directly.

Sure if you send the patch I'll just merge it into the series.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

