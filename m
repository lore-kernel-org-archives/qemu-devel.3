Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25582CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4F0D-0004fY-A2; Thu, 02 Oct 2025 04:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4F07-0004Xf-Ic
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:49:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Ezn-0002nI-Nq
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:49:23 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso482273f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394934; x=1759999734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qY2kYllh2DeRFIX0ZrCjnlmmM32KAee4L4TVEh4yQUQ=;
 b=NqlAx3XPv/P2SBZtBXWlY/k/mfj0B6hzX5bQK/fZqzwGqAlL/REtSZUslZY0Q6zXyk
 rRC7iyY8zkW2b/QYUbrIglWBbZ58yf3wsK/GWveTWd4+ZiJwN/jmXsFhc0rhU1mKksTS
 vxTR2HlQpDsJ9UIM8pfxRa3zJSSdRMNBQ/bY45a6q5NNG9+dJoJ63HciLCdgVGTBqiWk
 1M9hkyGRDMgg7BgTvXGq0Uv2wjjiuGuftmQuzBXQ9SN5/U7zBmPQ35Et1Lkntzom8jVX
 mb5s2ZIYYGF1Gwf6yMeUGFDw6mS/dSVJ44PES+TEE3W65UzHxNdvsfMJNW0NHbaB8ugj
 iesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394934; x=1759999734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qY2kYllh2DeRFIX0ZrCjnlmmM32KAee4L4TVEh4yQUQ=;
 b=p9onWVACUvroJePJyxB9PzikndqupE7sCa56/dR6qssRmRZD1GWjuvO6nD8zMJ80Tw
 7c35gFEoO+gxjxkM252GhZMdHNiqV/VWVUE1PmoF8vAw19ME0yctyILBFFEi7kDbv8CF
 FY2Ht22WIjfW85dgk4yDA0c2z1C2sMzlt7kWaJ72UrtiAjDcRrRzXmlP5x5Pqp4LEwha
 aL6hl7G4fGYM1J1AP/NlGYVNmpJDDybE0pZorKqaAk+7lzrzw803veMLdGm0ZaZV0D3Y
 X5EFXRsyjY/CDlbeD+CnvO7jLwzn4QRAsP2XzymbSDzB7Yh74XOeZWI56igo8ZggJngI
 jIJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZBYxEElKt/O5NbcrTaEA19C73kzolFFpCOnSG22cHQJg2u9rXh49GKnAKMOGawSg3xbs2pH89g0Hd@nongnu.org
X-Gm-Message-State: AOJu0Yy61noGjasFZbo1whVgvhr0CRNsh/hKR3vbFqCxmIl2pNfxBxBe
 ck49vwdF04tqgxU1jLWDum2MRX64A81D4mq2Yynm0ijfIPY0XHLqsoNfxXtDvS6vEpk=
X-Gm-Gg: ASbGncvVitEv32+P5ajEUh5Ge6XArI2Zugjfu7As02bTTmATt8UtxjLiOdjjVGVuWvO
 mS+PafUyADiRsfr3wYhkMZNqy7pOq8U5znvbtdFEJ9v2xgZh8IEOiRPJOmeTE+4IKsGs45cxnIy
 oR895UAsB3QFo+E0YhlflVsxUPPp0fckaz5KS3kPVR4wLWoZhcDF9IeetisrUKDVVb+EjD/2Drg
 K8TL1ybLb/u9Avzz+x1Ggiw3U5cMUgYg/ct0kIL6VlZHQlhf4wwJgLPjHuryYVEIXgS4PQAoMvR
 daYxWtQFejbLqcA2KsiybReg1jrB/RaE1tZZU9NfRbehN6lAl5d2au7R4UA1uzMKFUIdlxLm6QR
 nwLXmHBBudeNNWQI7Yjol4K3hA37qrj2SjLPJsd393PKY1s6C/n9POFIy7jhO09Qn+M87e6Esol
 v8fTekJzgJSVjckr85/bR2TGRGmM8+O2Ca6w==
X-Google-Smtp-Source: AGHT+IE+0qrFAPN/VI5+JfAzY30VNuqO+Cdlg3Rfx8ksPiGOlP0q/MgxGsJ0MlKxyHJwr22q8OviuQ==
X-Received: by 2002:a05:6000:240c:b0:3ea:6680:8f97 with SMTP id
 ffacd0b85a97d-425577ed8a3mr4555941f8f.2.1759394934148; 
 Thu, 02 Oct 2025 01:48:54 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97fbsm2642200f8f.34.2025.10.02.01.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 01:48:53 -0700 (PDT)
Message-ID: <2e78367f-e078-4af4-b664-5e10dd0f5c2f@linaro.org>
Date: Thu, 2 Oct 2025 10:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/27] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <e176dfe8-b406-46ff-b1f0-95d4285472b7@linaro.org>
 <aN46rF5w2-wy3IMH@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aN46rF5w2-wy3IMH@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 2/10/25 10:41, Daniel P. Berrangé wrote:
> On Thu, Oct 02, 2025 at 10:30:56AM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Magnus,
>>
>> On 16/9/25 18:48, Magnus Kulke wrote:
>>> Hello all,
>>>
>>> This is the fourth revision of a patch set implementing an accelerator
>>> for the MSHV kernel driver, exposing HyperV to Linux "Dom0" hosts in
>>> various scenarios. Thanks for the feedback to the previous revision, I
>>> tried to incorporate those. The changes in the currenct patchset beyond
>>> the suggested fixes are mostly related to the replacement of retired
>>> ioctl calls that will not part of the upstreamed MSHV kernel driver.
>>
>>
>>> Magnus Kulke (26):
>>>     accel: Add Meson and config support for MSHV accelerator
>>
>>>     accel/mshv: Add accelerator skeleton
>>>     accel/mshv: Register memory region listeners
>>>     accel/mshv: Initialize VM partition
>>>     accel/mshv: Add vCPU creation and execution loop
>>>     accel/mshv: Add vCPU signal handling
>>>     accel/mshv: Handle overlapping mem mappings
>>
>> Due to my generic work on accelerators, I'll have to refactor these
>> patches. Obviously I don't want to break your implementation! Can
>> you add some (functional?) tests? Ideally we should be running
>> tests on our CI to ensure code doesn't bitrot.
> 
> NB our CI systems don't have HyperV available, so it is unrealistic
> for us to test it in our CI upstream.

OK. Hopefully meson will autodetect it on x86_64 Linux hosts so at least
we'll compile & link.
That said, IIUC our Xen-only job should now use --disable-mshv:

.gitlab-ci.d/crossbuilds.yml:181:cross-amd64-xen-only:
.gitlab-ci.d/crossbuilds.yml-182-  extends: .cross_accel_build_job
.gitlab-ci.d/crossbuilds.yml-183-  needs:
.gitlab-ci.d/crossbuilds.yml-184-    - job: amd64-debian-cross-container
.gitlab-ci.d/crossbuilds.yml-185-  variables:
.gitlab-ci.d/crossbuilds.yml-186-    IMAGE: debian-amd64-cross
.gitlab-ci.d/crossbuilds.yml-187-    ACCEL: xen
.gitlab-ci.d/crossbuilds.yml-188-    EXTRA_CONFIGURE_OPTS: --disable-tcg 
--disable-kvm
.gitlab-ci.d/crossbuilds.yml-189-


Tests are optionally run on CI, having a test we can run locally is
still valuable.


