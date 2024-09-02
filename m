Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD62CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 14:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl83h-0004HL-A5; Mon, 02 Sep 2024 10:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl83e-00041x-Dd
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl83c-0005Qp-I9
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725287367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xjR40VRywavVOlYrFsBGfrthsbwuP6b1xTvyvduKhmo=;
 b=V4B9nAnexYcGvD2AOesOPGZCBc5nhEnUF0aM46QeXmqHV2QXcu3fCy+lX0+LyMF6V4J70V
 Oqgw2p3o11Kr1DGQ4yYyvprRb9fJEocSUhxb/IFQz3WO7S/VlG3MNgnv9mQXZwpSGUGrcz
 oRqKTs+q8Nc2GwjdYNRK5XuLps2UbDA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-K5C8WK61NaiFIsgcCxq_3Q-1; Mon, 02 Sep 2024 10:29:26 -0400
X-MC-Unique: K5C8WK61NaiFIsgcCxq_3Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-374c25d886aso1169518f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 07:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725287365; x=1725892165;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xjR40VRywavVOlYrFsBGfrthsbwuP6b1xTvyvduKhmo=;
 b=qpvcLyL2v8p7Tzh7rc9hn/7aYpTdlWoHUUBWAWND06+kF/tC7q8qreXktgAdWFw6/S
 1nSASLdUF4u3Z1OgKb+Yp3LYMecdBRgcp9VLfjlt6cYhfMt/hrNewZW2rDcxsOWDXRl7
 /RACWAfIj/6BxTmM+mxpIEm0VX+fhq7x8MeuJ67kJyaNxpL1DZHLyI94+z/KWOAz14Nm
 zwNvt7jc2gVM1nc8bjMFHiuyFWNtgTQYh4TlFQFJMahIYJYWHH0MT/62vR9AjUBDPZHv
 SYr5XpnehbnJOrN74pG1wsYjaB/vZOTC8cxlB+aZqXHTPj2GJUl5gPLFYGTDKCIr3JPj
 tEbg==
X-Gm-Message-State: AOJu0Yy6thqdL7e4JGRhkVQKjhQb89NJEoYFMSLh3U/3glRnkh4jDKy6
 VpBTboQdnj+pNUbsWEWwTc2g6aBixXOR0lufZkOaayMuEEpnEfZFmP/58Tjwx7ECRCxnvV+rK/g
 6jjNfpXC0sRBHoeFbeqvHw+TYtGJM652B4pBFU5j+oNvO2XtdX17P
X-Received: by 2002:a05:6000:1143:b0:374:d25f:101 with SMTP id
 ffacd0b85a97d-374d25f0282mr518696f8f.18.1725287365047; 
 Mon, 02 Sep 2024 07:29:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN7/qGXMCE2rZg1I+887nHl8QKR/y+yWaHHySEROFDYNcASP8ffUQy+pLx8Z6Zb+sqIO63XQ==
X-Received: by 2002:a05:6000:1143:b0:374:d25f:101 with SMTP id
 ffacd0b85a97d-374d25f0282mr518654f8f.18.1725287364271; 
 Mon, 02 Sep 2024 07:29:24 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.206.174])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbdda3958sm106886365e9.26.2024.09.02.07.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 07:29:23 -0700 (PDT)
Date: Mon, 2 Sep 2024 16:29:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v5 12/16] backends/confidential-guest-support: Add
 set_guest_policy() function
Message-ID: <zbhpccssgt34hmo4g6vrbgfgtvygzzgomx64wn7fzuczfpdmdd@5jlenkr6g3l5>
References: <cover.1723560001.git.roy.hopkins@suse.com>
 <25c486d1790d12a27efa6af3350154c4f5bbd187.1723560001.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25c486d1790d12a27efa6af3350154c4f5bbd187.1723560001.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Aug 13, 2024 at 04:01:14PM GMT, Roy Hopkins wrote:
>For confidential guests a policy can be provided that defines the
>security level, debug status, expected launch measurement and other
>parameters that define the configuration of the confidential platform.
>
>This commit adds a new function named set_guest_policy() that can be
>implemented by each confidential platform, such as AMD SEV to set the
>policy. This will allow configuration of the policy from a
>multi-platform resource such as an IGVM file without the IGVM processor
>requiring specific implementation details for each platform.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>---
> backends/confidential-guest-support.c     | 12 ++++++++++++
> include/exec/confidential-guest-support.h | 21 +++++++++++++++++++++
> 2 files changed, 33 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>index 68e6fd9d18..3c46b2cd6b 100644
>--- a/backends/confidential-guest-support.c
>+++ b/backends/confidential-guest-support.c
>@@ -38,6 +38,17 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>     return -1;
> }
>
>+static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
>+                            uint64_t policy,
>+                            void *policy_data1, uint32_t policy_data1_size,
>+                            void *policy_data2, uint32_t policy_data2_size,
>+                            Error **errp)
>+{
>+    error_setg(errp,
>+               "Setting confidential guest policy is not supported for this platform");
>+    return -1;
>+}
>+
> static int get_mem_map_entry(int index, ConfidentialGuestMemoryMapEntry *entry,
>                              Error **errp)
> {
>@@ -52,6 +63,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc, void *data)
>     ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>     cgsc->check_support = check_support;
>     cgsc->set_guest_state = set_guest_state;
>+    cgsc->set_guest_policy = set_guest_policy;
>     cgsc->get_mem_map_entry = get_mem_map_entry;
> }
>
>diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
>index 058c7535ca..6a9ccc2454 100644
>--- a/include/exec/confidential-guest-support.h
>+++ b/include/exec/confidential-guest-support.h
>@@ -59,6 +59,10 @@ typedef enum ConfidentialGuestPageType {
>     CGS_PAGE_TYPE_REQUIRED_MEMORY,
> } ConfidentialGuestPageType;
>
>+typedef enum ConfidentialGuestPolicyType {
>+    GUEST_POLICY_SEV,
>+} ConfidentialGuestPolicyType;
>+
> struct ConfidentialGuestSupport {
>     Object parent;
>
>@@ -123,6 +127,23 @@ typedef struct ConfidentialGuestSupportClass {
>                            ConfidentialGuestPageType memory_type,
>                            uint16_t cpu_index, Error **errp);
>
>+    /*
>+     * Set the guest policy. The policy can be used to configure the
>+     * confidential platform, such as if debug is enabled or not and can contain
>+     * information about expected launch measurements, signed verification of
>+     * guest configuration and other platform data.
>+     *
>+     * The format of the policy data is specific to each platform. For example,
>+     * SEV-SNP uses a policy bitfield in the 'policy' argument and provides an
>+     * ID block and ID authentication in the 'policy_data' parameters. The type
>+     * of policy data is identified by the 'policy_type' argument.
>+     */
>+    int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
>+                            uint64_t policy,
>+                            void *policy_data1, uint32_t policy_data1_size,
>+                            void *policy_data2, uint32_t policy_data2_size,
>+                            Error **errp);
>+
>     /*
>      * Iterate the system memory map, getting the entry with the given index
>      * that can be populated into guest memory.
>-- 
>2.43.0
>


