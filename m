Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CDBC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24yN-00063F-5S; Thu, 03 Sep 2026 06:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x24yL-000635-TZ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:47:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x24yK-0007jg-22
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788432426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hf8yu5d7GebbmHWi/7eHO3R3u498r/IQfuzDpLs9L7g=;
 b=WT0S713WGK7UXUA9pO7Yy8MzsUT54BI+j2GTaMoyBgoziPUeM/toIUjWnNw2J4G34jC5P5
 AGvt79uOKP99+VbxLhcjZhMqAWLXB6GZCr6JTxfybmG410QuNyp3fcbyuISp79Y78Ufyfn
 P83n4qQQ1KpkB3yZXc5xvi8N9bm9/wQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-Kb4JCc5mOA6IFBvaa_mjgw-1; Thu, 03 Sep 2026 06:47:05 -0400
X-MC-Unique: Kb4JCc5mOA6IFBvaa_mjgw-1
X-Mimecast-MFC-AGG-ID: Kb4JCc5mOA6IFBvaa_mjgw_1788432424
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cf4cc2125so1104585e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788432424; x=1789037224; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hf8yu5d7GebbmHWi/7eHO3R3u498r/IQfuzDpLs9L7g=;
 b=GsIOPD2Oj7xLZr8lwvgy/wDsjSvWSUBWf+F/DEGlTxG//7OqESbtCn1tzmRhOx+o6C
 YP27jEYzm5ntK0lZZJ6Zh6kpTKGiw1mAjCv23FMPtiLg0Lt+CgH0rn27qo2TrHG2SiBW
 +Mv32aCm/yZyC6bVpZ3DGzbOiqKC2oIIndCH32o6PvqzPIuLAwSC0JyJz4Ss0WEEG+Ft
 VqozCXbX42c/YolwCh18EN5+p7aBFqC3dI/6ZyNqScJEKQMXycNgz4B7iRgmmbpS3ffP
 LtufBfVSvvDGWqjA3nZFSATMsBuVVtfS/LpPiZA2Hton0vJyX8kdO319zz8LxqXBHXcX
 vz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432424; x=1789037224;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hf8yu5d7GebbmHWi/7eHO3R3u498r/IQfuzDpLs9L7g=;
 b=FNpmFE0lIASJn1wMvkS3O+nfhk+1XV27Exa5p2RwEOZZkUfKQO+eG/kYs/nAGABjCl
 OjtGVB5rOcyJ6JB18d/kS3PmFK7zowWxcCc4kH3wEonqrGGPLMImYG2+lzfnZtN0vTFI
 ymtC92W3Q1wQSD/DQfHIMGxIcoC761XaBUFbiEt8+DDKOs7Uy5/cFOr1weIw3eCtHDcC
 3ngXrRoq70b4qclnYglkPEG6mpERgbW0p9RddlPK3vICHd0jc5Xg6A/6er0DCkgyaacm
 rvmsmWHwFX5vfrX5PELujsdsq5iX8S8Hn9biY9B4ptNDWsOqmxf3FmH6PmJDgEVnJlaC
 Q0wg==
X-Gm-Message-State: AFuF++nvXmJWRa42HWJLiXWnYdI6f22ALbE+JEffUq6FYwQgKw7xC89g
 Ilr5fyZK/UVa+0HFXwA5L8EMRSVUqx+BTntxJ/N7nP+GU3YGG8QKTiMvjd//l6ZPF0Fbzqmt2z9
 j0R1YR/8Eg3e54T+Qif8D4megZkTByrYgP7r3l4S+QGH+OvfmW7XZkByT
X-Gm-Gg: AYBFou3rmKTBZIZr9kZF0/2mmLzRkq4YJwBqh6B7G3h+hLyrqz5OSWg1ZJiBM9WRorH
 BrCNYTaVpirSNEEKNtaiJ2tv9Fk8zkYBFPEYbCNbjc87vnJld5ir4VHsitBq9aQ7PcNvZyH6uWg
 2QhHIQxlX0GOAtpNtxBHsJj+ggCa4CfgtTNpRZOHttQIFd3jkYZf641i6164tR9RA57fq2CLVFV
 TpT08dDU5s0p9vtV022xLtvjHR8jetBBUou5U2sNPRPQMiol1I9zo5ofrphUWeFjClhiidtiqlu
 G5jEgEF69p2DBLklCQyTUmi+1s2qN+k/AtBppYLTPk6p71g89QT8BeraSZf51sn9VXUax9/yrT4
 Css+eJ2m22Izj66Yv/4cn8Vhzh7zVKWQ1E6M=
X-Received: by 2002:a05:600c:8714:b0:499:b65d:1250 with SMTP id
 5b1f17b1804b1-49ce580d869mr204539285e9.2.1788432423982; 
 Thu, 03 Sep 2026 03:47:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8714:b0:499:b65d:1250 with SMTP id
 5b1f17b1804b1-49ce580d869mr204538535e9.2.1788432423542; 
 Thu, 03 Sep 2026 03:47:03 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d6029sm63445225e9.6.2026.09.03.03.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 03:47:02 -0700 (PDT)
Date: Thu, 3 Sep 2026 12:47:00 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH 1/4] sev: rename set_guest_policy to set_id_block and
 remove dead policy code
Message-ID: <aplPIuIgLYKofjGq@leonardi-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-1-e93a6cf8c5ac@redhat.com>
 <aplMPpjG6X__JZeM@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aplMPpjG6X__JZeM@sgarzare-redhat>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
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

On Thu, Sep 03, 2026 at 12:32:21PM +0200, Stefano Garzarella wrote:
>On Tue, Sep 01, 2026 at 12:09:18PM +0200, Luigi Leonardi wrote:
>>The guest policy must be provided at guest launch start: LAUNCH_START for
>>SEV/SEV-ES and SNP_LAUNCH_START for SEV-SNP. See the SEV API
>>specification, chapter 3 (Guest Policy), and the SEV-SNP firmware ABI
>>specification, section 4.3 (Guest Policy).
>>
>>The policy parameter in set_guest_policy was never effective: by the
>>time this callback runs, LAUNCH_START has already been issued for both
>>SEV/SEV-ES and SEV-SNP, so writing to kvm_start_conf.policy or
>>sev_guest->policy has no effect. In practice the only thing this
>>callback actually does is set the ID block and ID auth for SNP's
>>LAUNCH_FINISH, so rename it to set_id_block to reflect its real
>>purpose, remove the unused policy parameter, and drop the non-SNP code
>>path which was entirely dead.
>>
>>This is preliminary work: actually forwarding the guest policy to the
>>platform before LAUNCH_START is added in a later commit.
>
>IIUC the behaviour is the same after this patch, but IMO better to
>clarify.

Yep, will do.

>
>>
>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>---
>>backends/confidential-guest-support.c       |  12 ++-
>>backends/igvm.c                             |   6 +-
>>include/system/confidential-guest-support.h |  28 ++++---
>>target/i386/sev.c                           | 118 +++++++++++-----------------
>>4 files changed, 67 insertions(+), 97 deletions(-)
>>
>>diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>>index 156dd15e66..a0b36d2da5 100644
>>--- a/backends/confidential-guest-support.c
>>+++ b/backends/confidential-guest-support.c
>>@@ -38,14 +38,12 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>>    return -1;
>>}
>>
>>-static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
>>-                            uint64_t policy,
>>-                            void *policy_data1, uint32_t policy_data1_size,
>>-                            void *policy_data2, uint32_t policy_data2_size,
>>-                            Error **errp)
>>+static int set_id_block(void *id_block, uint32_t id_block_size,
>>+                        void *id_auth, uint32_t id_auth_size,
>>+                        Error **errp)
>>{
>>    error_setg(errp,
>>-               "Setting confidential guest policy is not supported for this platform");
>>+               "Setting ID block is not supported for this platform");
>>    return -1;
>>}
>>
>>@@ -64,7 +62,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
>>    ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>>    cgsc->check_support = check_support;
>>    cgsc->set_guest_state = set_guest_state;
>>-    cgsc->set_guest_policy = set_guest_policy;
>>+    cgsc->set_id_block = set_id_block;
>>    cgsc->get_mem_map_entry = get_mem_map_entry;
>>}
>>
>>diff --git a/backends/igvm.c b/backends/igvm.c
>>index 7b7bdc72b7..85de0d54ec 100644
>>--- a/backends/igvm.c
>>+++ b/backends/igvm.c
>>@@ -968,9 +968,9 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
>>            id_block_len = sizeof(struct sev_id_block);
>>            id_auth_len = sizeof(struct sev_id_authentication);
>>        }
>>-        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, 
>>ctx->sev_policy,
>>-                                          ctx->id_block, id_block_len,
>>-                                          ctx->id_auth, id_auth_len, errp);
>>+
>>+        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
>>+                                       ctx->id_auth, id_auth_len, errp);
>>    }
>>    return 0;
>>}
>>diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
>>index 5dca717308..6d35ddb97a 100644
>>--- a/include/system/confidential-guest-support.h
>>+++ b/include/system/confidential-guest-support.h
>>@@ -128,21 +128,23 @@ typedef struct ConfidentialGuestSupportClass {
>>                           uint16_t cpu_index, Error **errp);
>>
>>    /*
>>-     * Set the guest policy. The policy can be used to configure the
>>-     * confidential platform, such as if debug is enabled or not and can contain
>>-     * information about expected launch measurements, signed verification of
>>-     * guest configuration and other platform data.
>>-     *
>>-     * The format of the policy data is specific to each platform. For example,
>>-     * SEV-SNP uses a policy bitfield in the 'policy' argument and provides an
>>-     * ID block and ID authentication in the 'policy_data' parameters. The type
>>-     * of policy data is identified by the 'policy_type' argument.
>>+     * Set the guest policy for the confidential platform. The policy
>>+     * configures properties of the guest, such as whether debug is
>>+     * enabled. Its format is platform-specific; for SEV/SEV-ES and
>>+     * SEV-SNP it is a policy bitfield. Must be called before LAUNCH_START
>>+     * so the policy is in effect for launch.
>>     */
>>    int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
>
>I'm confused, this commit says "rename set_guest_policy to set_id_block"
>so why this callback is still here?
>

We will need this callback in a following patch, so I thought that removing
it to then add it again was pointless. If you prefer I can go this
route, or I can specify it in the commit message.

Luigi


