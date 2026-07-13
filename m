Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC2AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 00:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj4kA-0000hp-7m; Sun, 12 Jul 2026 20:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wj4k9-0000hY-B5
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 20:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wj4k7-0004Q3-IS
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 20:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783903313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zALpRgeuYhXdSugXMHp9pMhVnEo4bMgEkE82Q4hNxJU=;
 b=WXXNu5MzaMbaXlMU1gbqBSQtQnbmRi3vCi5uphlnc7THx8gP+1gLUVjlmbUsSs08HNaAl0
 lbJk9F877UUunkcPaVh+tt862Ph1Mcp+G3/nq/9fFChHqKP9emyEcA3dVvupdJaGdMBvTJ
 3Nd7m3wCr1yHMzDeQqf5q1vVIMwAAtY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-7wgiw0xqN0qOwIDzl2iWjQ-1; Sun, 12 Jul 2026 20:41:52 -0400
X-MC-Unique: 7wgiw0xqN0qOwIDzl2iWjQ-1
X-Mimecast-MFC-AGG-ID: 7wgiw0xqN0qOwIDzl2iWjQ_1783903311
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84240683a82so2369143b3a.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 17:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783903311; x=1784508111; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zALpRgeuYhXdSugXMHp9pMhVnEo4bMgEkE82Q4hNxJU=;
 b=P5TF0ByOr0MKfLMysMh5kULaSFLKtQQd9Zx3gQ9DQsM4lCsF1jFHaXgY7jAEb3QoBO
 wtb0vIRD/WQnDjfmCtqVyZvYfrYNIcaibfcbgCd5O4Fr0d1yyXlDFnh8EbWdN3P3691U
 qhez9Y1m+eg3yhyRP8A7gtkwDSiwFvSNvIAG4aUzugK6E8jM0guO/a1bV7pcqQdJd5eC
 C7yp2USp8yeynmIcaN26NpeQ3Es3ZEqXO5lc+PHD75Qo0MXQ94IyuQ7ha31UmBWlRhvx
 tGhciYEOzF3xmLDx/CdaO2sL2t0SrypbfvF8CHH3aXtwmTtPvOowCMdgvuScn21hkUZ/
 0R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783903311; x=1784508111;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zALpRgeuYhXdSugXMHp9pMhVnEo4bMgEkE82Q4hNxJU=;
 b=OP7gcKh1g+tzLboKpb+LtEmW+ZpHqj6zTiwW1QhI+M5TF1ITtQbbVXrKAVDXmXvLYm
 y4ySRPaqyi3BeFPsGr9fai7Znw6kP83MLAc7pGUtIhzAr/Zd4WdslgNKI38hrXEuUklN
 wmgxd4W3XgkneSVp8g1rsXC/mOzyXF7oYP/AQnedfsoQgVsCidfoHDF5Sh2Y+PHh5hzH
 CnNtVGVoOUBrdBMN/XRenye74As0dO6byoGNWVvXoDQAmmdtt98ADpIeWDXFmllcMJX/
 +osYysBehKwlC0df1vU5ATT7M2fZfTbfTHUJikXGlwpJUzD/f7moit7XWK+TnGb3sk63
 rBEA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1D/6M6rx2gwFwm0GYn2z27ZcQk0oN3f0uvmL+zBalIBDfEcCrZhbIbKtJern6Lhx0yjyKuHmi1LIL@nongnu.org
X-Gm-Message-State: AOJu0YyjsbzbYrpzJjEQlVm7lnK5qguqt1qLXUEO/2ltdqansiQos4RH
 VUU1tlQw2ig/x2aCY976IoLrzRftlOPhKQKIUb1MNRJjZ1nqScngKrmg4Bi+B7EklcabP7rceb2
 W8RkLonrq+XT4xDbV97i5FGZ9GuBkxW2wPTHLllY7mJXjkfAnn4oPhjLf
X-Gm-Gg: AfdE7cm5kazJpDIKpcPRvqxe9XdDV3Y+M1zKD1YjCHFzC7ipN26Wf/0G3RHvSmZSkNg
 ignIXgT9ynwCbOTvU4tABXrE8v3uZrj4jK2rGsS0i6khIf5bsW048M1B5pIPQXOB7+1iFNAgIKQ
 cy7QxMQ+4rSyPqY4vG3z9/4UqFcJ4M9qXv4bYP642Dd+HguHcAhwDhlJ/QsH76po6BH04eftJCa
 yP9dKbEjC25+hq08hr7/oEntPZhasVe7JduWVst7QSpkCLqmtf22mt+UtiIi+KzEHqnqvSnisMP
 GOfzUA7X4se+B2CvZcNPCyKk788rTSMuAFZkeTkLTs5zhhtzOMbIBshIPqATwGY/BYU/cfPhb5m
 wHLVGEocuDhN7OBnwpX7u8RkDFi+LQ0W1eSzN9R+ZxB0VFv+kykx4aA==
X-Received: by 2002:a05:6a00:a20f:b0:847:9aa8:d3c1 with SMTP id
 d2e1a72fcca58-8487078c197mr10333601b3a.34.1783903310890; 
 Sun, 12 Jul 2026 17:41:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:a20f:b0:847:9aa8:d3c1 with SMTP id
 d2e1a72fcca58-8487078c197mr10333587b3a.34.1783903310424; 
 Sun, 12 Jul 2026 17:41:50 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8483262a17dsm8553175b3a.4.2026.07.12.17.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jul 2026 17:41:49 -0700 (PDT)
Message-ID: <8ecc5bdb-7686-4627-a2d5-94c50d7921b4@redhat.com>
Date: Mon, 13 Jul 2026 10:41:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 01/25] linux-headers: Add RME related definitions
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-2-mathieu.poirier@linaro.org>
 <03a39e32-3b15-49a3-a23a-782f8ba25466@redhat.com>
 <alDNbZ4ZI34nPGKo@lpieralisi>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <alDNbZ4ZI34nPGKo@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=gshan@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/10/26 8:46 PM, Lorenzo Pieralisi wrote:
> On Fri, Jul 10, 2026 at 11:09:43AM +1000, Gavin Shan wrote:
> 
> [...]
> 
>> After syncing the definitions with those in (v14) host series, I'm able to boot
>> a simple realm guest (no virtio devices) with one warning.
>>
>>    qemu-system-aarch64: Failed to enable KVM_CAP_ARM_NISV_TO_USER cap
> 
> That's because we need to use the VM instance specific check extension
> rather than the global one before trying to enable the cap.
> 
> It is harmless.
> 

Yes, the capability KVM_CAP_ARM_NISV_TO_USER has been hidden from realm guest
in the (v14) host series. With the following changes applied on the top, the
warning is avoided, I think the changes need to be integrated to [RFC v1 08/25]
target/arm/kvm: Use kvm_vm_check_extension() where necessary.

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3d5e16a21c..4c52ee7e1b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -623,7 +623,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
          return -EINVAL;
      }
  
-    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
+    if (kvm_vm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
          if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
              error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
          } else {

Besides, I think it's known issue that 'reboot' doesn't work.

   Welcome to Buildroot
   buildroot login: root
   root@guest:~# reboot
     :
   qemu-system-aarch64: cpus are not resettable, terminating

Thanks,
Gavin

> Lorenzo
> 


