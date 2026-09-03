Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F09C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27ux-00042B-Di; Thu, 03 Sep 2026 09:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x27us-00041M-T6
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x27uq-0007Jz-Np
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788443741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LG9wJQZdEFX9IF9VRJWkFSFa8IfSUIjwtb28/dYOTyA=;
 b=cbpDdtbAHNzcVMbRWuKgjyDCgnv9rHKbW+EUlQGSyniQtw1EAi8IPSMsyAhp+gCj4kIbWK
 HNRHMFRRxqDcqvxVDa5SsE1jkqT03RO2I2Gm9MfplTsFVKnM+DrIiflahWEEtednmgOpY7
 ZPM+pamaNgTbw1Ht6d2GawpNJoRiJw4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-GhoWDHv_NP-V3oofAvGdjQ-1; Thu, 03 Sep 2026 09:55:40 -0400
X-MC-Unique: GhoWDHv_NP-V3oofAvGdjQ-1
X-Mimecast-MFC-AGG-ID: GhoWDHv_NP-V3oofAvGdjQ_1788443739
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4843e59c32dso1370345f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788443739; x=1789048539; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LG9wJQZdEFX9IF9VRJWkFSFa8IfSUIjwtb28/dYOTyA=;
 b=q+1M+po/CqjpKjSELC0cSwZuhASOnp40zeTLHD4zHgBl1M64eyJ3kXDQSDOvtvsBk7
 NkKV0VSFm6/RETGI7LninuZXzrRpW/C0y+CYxk/vbYkJJUyzQxNTQnP2L4f2nnWnpoPy
 KqZGBaMwUsQ7HlyfpnX7qL3Y+wtybek40mqBXpu9KgaCW4K7zvqCDrQUij3IJHJME8G/
 Z3rA+XK7/+hy510x1iSQt7V6B5fTOH4bNTtPxOjn1SIICtgLVWPnaAfMuFnBqS9v76x3
 iaLqBJDfJIecV9qvnunKqKmzs4byAeuzW2zHV5mTJg5Sjuhtn1BT53jbvknxjIMoE8zD
 Vtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443739; x=1789048539;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LG9wJQZdEFX9IF9VRJWkFSFa8IfSUIjwtb28/dYOTyA=;
 b=mQfDpVSrJSrROctikLVAAnE8fMfQ9DOvwr54NVvyY65Deqi5rnZgJyU9f50kuSBfEw
 DiFBsmaBt5iPfw2qzN4oFzu+BJQvUnE7oGaEMskX5OPycBKNabgAj9J0U5j8Ezh4c/KY
 SRjSbeB4/HpxqwhVApRfB8BFZfTqZ3vevhMFn1lk/7LC9PkzuzNHjNaccKEOHXROepHZ
 ClgeHVLtoFjkmCrCCu505jjVtc/nOrJg+TJ10gvc8pNBAQTMZN2+vfwb3u07Jjo+dMnq
 NTnLgNRy1zq2UOwazZCeE36+7qsrcUDSxs8/q5RjOMeB41wjq/W93zt06eeLrJgA/Yqr
 JgLQ==
X-Gm-Message-State: AFuF++kA6Rhmwvhk3m1inYRWyVBbcE3FeaTSJFGqUDwNjfM1XlzKb49I
 14/6RqmPkv2+kW6oMJ7bE/3PS0Xeptf5nciuIYdJbduEnNZGJsjAjOkhePC6J50BFphoBa+RByz
 rwttHeh4INbHh9UTuUQogmnVshl0vvJeOAZWPSVe8N4UShQpJZW8vOkSC
X-Gm-Gg: AYBFou2X5CVqsa3/bt+IFcVUtUS6lyjV3DRi6XnTSYrC0A2tyYIXr4dmps9ZjiAF6MC
 UQ5+8rjAph+9/JDgW6bVmHDQOj3RofsTg5oHeVZi88W6t1Iid2UgAN1fJ56/x2YW3SJzXI1K8QT
 yCblmT4UMNUhEeWjFZB/PRe3cZ9Q98d5zZ/mxUwcsn/Exwsrn//A7nkyGKteD+lTrIqLVi5J8aR
 EKysXiaIovsLJaMDXVljoC27GrysXDRDLR27mqjA2HZYrltXkY1JIxfH3/8h1SGZIXXi952gmku
 wQsi6HIW/bwS4YEHWpZPAdCTt9ldhfkhc0oNx9VQNG796Dv9lzWBYlCAvCGHL5ZXP9vWjokYPLR
 kkrOqMG6lEqzMa64Aq/a2wEaV8q8ikSw0coy4azoofK9eDg==
X-Received: by 2002:a05:6000:46d9:b0:482:e2f2:19c1 with SMTP id
 ffacd0b85a97d-48586028a7dmr774351f8f.2.1788443739241; 
 Thu, 03 Sep 2026 06:55:39 -0700 (PDT)
X-Received: by 2002:a05:6000:46d9:b0:482:e2f2:19c1 with SMTP id
 ffacd0b85a97d-48586028a7dmr774262f8f.2.1788443738736; 
 Thu, 03 Sep 2026 06:55:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492cf550sm14134925f8f.37.2026.09.03.06.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:55:37 -0700 (PDT)
Date: Thu, 3 Sep 2026 15:55:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH 1/4] sev: rename set_guest_policy to set_id_block and
 remove dead policy code
Message-ID: <apl2D4DKmfHohZdF@sgarzare-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-1-e93a6cf8c5ac@redhat.com>
 <aplMPpjG6X__JZeM@sgarzare-redhat>
 <aplPIuIgLYKofjGq@leonardi-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aplPIuIgLYKofjGq@leonardi-redhat>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 03, 2026 at 12:47:00PM +0200, Luigi Leonardi wrote:
>On Thu, Sep 03, 2026 at 12:32:21PM +0200, Stefano Garzarella wrote:
>>On Tue, Sep 01, 2026 at 12:09:18PM +0200, Luigi Leonardi wrote:
>>>The guest policy must be provided at guest launch start: LAUNCH_START for
>>>SEV/SEV-ES and SNP_LAUNCH_START for SEV-SNP. See the SEV API
>>>specification, chapter 3 (Guest Policy), and the SEV-SNP firmware ABI
>>>specification, section 4.3 (Guest Policy).
>>>
>>>The policy parameter in set_guest_policy was never effective: by the
>>>time this callback runs, LAUNCH_START has already been issued for both
>>>SEV/SEV-ES and SEV-SNP, so writing to kvm_start_conf.policy or
>>>sev_guest->policy has no effect. In practice the only thing this
>>>callback actually does is set the ID block and ID auth for SNP's
>>>LAUNCH_FINISH, so rename it to set_id_block to reflect its real
>>>purpose, remove the unused policy parameter, and drop the non-SNP code
>>>path which was entirely dead.
>>>
>>>This is preliminary work: actually forwarding the guest policy to the
>>>platform before LAUNCH_START is added in a later commit.
>>
>>IIUC the behaviour is the same after this patch, but IMO better to
>>clarify.
>
>Yep, will do.
>
>>
>>>
>>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>---
>>>backends/confidential-guest-support.c       |  12 ++-
>>>backends/igvm.c                             |   6 +-
>>>include/system/confidential-guest-support.h |  28 ++++---
>>>target/i386/sev.c                           | 118 +++++++++++-----------------
>>>4 files changed, 67 insertions(+), 97 deletions(-)
>>>
>>>diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>>>index 156dd15e66..a0b36d2da5 100644
>>>--- a/backends/confidential-guest-support.c
>>>+++ b/backends/confidential-guest-support.c
>>>@@ -38,14 +38,12 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>>>   return -1;
>>>}
>>>
>>>-static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
>>>-                            uint64_t policy,
>>>-                            void *policy_data1, uint32_t policy_data1_size,
>>>-                            void *policy_data2, uint32_t policy_data2_size,
>>>-                            Error **errp)
>>>+static int set_id_block(void *id_block, uint32_t id_block_size,
>>>+                        void *id_auth, uint32_t id_auth_size,
>>>+                        Error **errp)
>>>{
>>>   error_setg(errp,
>>>-               "Setting confidential guest policy is not supported for this platform");
>>>+               "Setting ID block is not supported for this platform");
>>>   return -1;
>>>}
>>>
>>>@@ -64,7 +62,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
>>>   ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>>>   cgsc->check_support = check_support;
>>>   cgsc->set_guest_state = set_guest_state;
>>>-    cgsc->set_guest_policy = set_guest_policy;
>>>+    cgsc->set_id_block = set_id_block;
>>>   cgsc->get_mem_map_entry = get_mem_map_entry;
>>>}
>>>
>>>diff --git a/backends/igvm.c b/backends/igvm.c
>>>index 7b7bdc72b7..85de0d54ec 100644
>>>--- a/backends/igvm.c
>>>+++ b/backends/igvm.c
>>>@@ -968,9 +968,9 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
>>>           id_block_len = sizeof(struct sev_id_block);
>>>           id_auth_len = sizeof(struct sev_id_authentication);
>>>       }
>>>-        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, 
>>>ctx->sev_policy,
>>>-                                          ctx->id_block, id_block_len,
>>>-                                          ctx->id_auth, id_auth_len, errp);
>>>+
>>>+        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
>>>+                                       ctx->id_auth, id_auth_len, errp);
>>>   }
>>>   return 0;
>>>}
>>>diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
>>>index 5dca717308..6d35ddb97a 100644
>>>--- a/include/system/confidential-guest-support.h
>>>+++ b/include/system/confidential-guest-support.h
>>>@@ -128,21 +128,23 @@ typedef struct ConfidentialGuestSupportClass {
>>>                          uint16_t cpu_index, Error **errp);
>>>
>>>   /*
>>>-     * Set the guest policy. The policy can be used to configure the
>>>-     * confidential platform, such as if debug is enabled or not and can contain
>>>-     * information about expected launch measurements, signed verification of
>>>-     * guest configuration and other platform data.
>>>-     *
>>>-     * The format of the policy data is specific to each platform. For example,
>>>-     * SEV-SNP uses a policy bitfield in the 'policy' argument and provides an
>>>-     * ID block and ID authentication in the 'policy_data' parameters. The type
>>>-     * of policy data is identified by the 'policy_type' argument.
>>>+     * Set the guest policy for the confidential platform. The policy
>>>+     * configures properties of the guest, such as whether debug is
>>>+     * enabled. Its format is platform-specific; for SEV/SEV-ES and
>>>+     * SEV-SNP it is a policy bitfield. Must be called before LAUNCH_START
>>>+     * so the policy is in effect for launch.
>>>    */
>>>   int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
>>
>>I'm confused, this commit says "rename set_guest_policy to set_id_block"
>>so why this callback is still here?
>>
>
>We will need this callback in a following patch, so I thought that removing
>it to then add it again was pointless. If you prefer I can go this
>route, or I can specify it in the commit message.

I see your point about avoiding remove and re-add the callback, but
self-contained commits aren't a matter of preference or taste, they're
a maintainability requirement. A callback declared but unimplemented
across three commits leaves the API in an incomplete state.

Please move the set_guest_policy declaration where it's first used.

Thanks,
Stefano


