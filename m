Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03520C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 09:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdRNL-0004Sm-Av; Mon, 12 Aug 2024 05:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sdRNJ-0004Qk-H6
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sdRNH-0003Kn-0z
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723454997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZatMmrClv0aTLwZezj5tD8JVw5xv2o3tcbRjXncUC30=;
 b=ZXNSSIKXISHrDl18eoWZUSsJCWhRgYIDtDCMXHlz/fFSo7Gygpmwpinbxkhmkhr1STr3j+
 Mf4mxfsRWo0PHjt3M4RzrPcvPGZF6Y637zLrIqbz2Cv9/i4MbJbOG8cX4za/+N4WuTO3X7
 3A5V9dDjgGb0x5FlNs9DZ42LS1GmX4w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-oHOvoul3M6CLOfJ8zRWWxg-1; Mon, 12 Aug 2024 05:29:55 -0400
X-MC-Unique: oHOvoul3M6CLOfJ8zRWWxg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3685bbd6dfbso2418403f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 02:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723454994; x=1724059794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZatMmrClv0aTLwZezj5tD8JVw5xv2o3tcbRjXncUC30=;
 b=nR0rj8t/bPF1rMa0QXoYcdVPG1hfbbNrj9NP6p+96qDXXfgLk9F8Pm/Y+M0rYJPPTJ
 nFhoZUgLjuNdTbJUxnhOXhvaz43H4DiYCsIRqaNDnCh9rcagOXrJ/Udg5HjVLRfeCCk0
 8psTT2E1TybE9jxDjRoAwpVdPpDcrN5Fp3RF+yfov8lbKisydoHo8+uy5Uz/7PO8DQad
 MT9shV5pwPQmMM1iN1de3FNIZZf7dwLav1H298YDP0l0hN3ThId7un58wMDsgv14EJwT
 leBOdWea9+nRA6+Is8g+Z7OpjKigXuaitcviQmj5YfPoegT6J5T77YaU8NjR6jIBOLjB
 ip3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg5MmUsQzB/QWyqSLftH18TDZOvqHUEDY8JlLEgvGwJNhmoeZogwxvfIPRlOSm5u9fljNO49LlEbzr@nongnu.org
X-Gm-Message-State: AOJu0YzMWJSrkRIjElPRwtyNz/4k2Xjp0Dc0cpZXco7HiujfwifsfhZk
 haDsrscRlObbmz7S6Q+Pi4D8/zT3oYl6QELzNYAyUcHim8YGyyfaz0ooZJFNKyVMEbdAdVspPIz
 HDq6glX868+YIvNwscwlic0k6u27dnhOFeU2ANFKVEE+AFUYBLTiO/ht/jnQH3MgMQY5jRXDhAr
 izuDOcyf6Hq1ENSol0bcq4jKk/ky8=
X-Received: by 2002:a5d:6845:0:b0:367:9624:f369 with SMTP id
 ffacd0b85a97d-36d5fa9e7a4mr4852462f8f.16.1723454993887; 
 Mon, 12 Aug 2024 02:29:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6wjJUKlaOYzIoJW0XsH2eaBSiWS6x0QETdF7Wj+c9wicto0KdI7PTgO3ESYMF4RKQ8CUz4srMO1iz2UCNdiE=
X-Received: by 2002:a5d:6845:0:b0:367:9624:f369 with SMTP id
 ffacd0b85a97d-36d5fa9e7a4mr4852440f8f.16.1723454993450; Mon, 12 Aug 2024
 02:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
 <rust-pl011-rfc-v6-5.git.manos.pitsidianakis@linaro.org>
 <9a83a260-4f4c-477b-a6e1-c8d78d1f3039@redhat.com>
 <3891718f-2f15-435d-a7de-cc40492374f0@intel.com>
In-Reply-To: <3891718f-2f15-435d-a7de-cc40492374f0@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Aug 2024 11:29:41 +0200
Message-ID: <CABgObfaKcMy8Y_HXL+s_8Bpz_UoV3Md+rYvbHdJHEGDiDd1sQA@mail.gmail.com>
Subject: Re: [RFC PATCH v6 5/5] rust: add PL011 device model
To: Junjie Mao <junjie.mao@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Aug 12, 2024 at 10:51=E2=80=AFAM Junjie Mao <junjie.mao@intel.com> =
wrote:
> I tested that branch by a cross-build to aarch64 on an x86_64 machine (wi=
th
> "./configure --cross-prefix=3Daarch64-linux-gnu-
> --rust-target-triple=3Daarch64-unknown-linux-gnu"). To configure successf=
ully, I
> need to add "native: true" to every "dependency()" that refers to those
> dependencies. Also their "override_dependency" needs a "native: true" as =
well.
> Here are my detailed changes:

Great, thanks for the testing.  I applied your changes and also
removed "-native" according to your suggestion.


Paolo


