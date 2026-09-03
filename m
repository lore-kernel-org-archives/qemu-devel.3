Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1A9C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25DL-0000pU-En; Thu, 03 Sep 2026 07:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x25DJ-0000p8-Sb
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x25DF-0001o2-P0
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788433352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=82nGEyjblHhHI3MrDMVBXgTcu8gABpUQwBchRyQe4V0=;
 b=H8+mSjr1s5lQpk8Lg/il8EN3Lfnr82jihYg1dgxMtbsy852K6cnehBBwdxpvxTZ/ZAAPv2
 gNl7r5P7Sg6VoNw+ZABA4sogpzxWl5JZtje/pMNtL5Jlk2raB5zFxOh7GcIgGzKd4o6acD
 RBy3AuZDBntE1WN/qemiIJI3vek+AHk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-zLZeNZ8GOkCSt-2_SCKPhg-1; Thu, 03 Sep 2026 07:02:30 -0400
X-MC-Unique: zLZeNZ8GOkCSt-2_SCKPhg-1
X-Mimecast-MFC-AGG-ID: zLZeNZ8GOkCSt-2_SCKPhg_1788433349
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49991beee7aso20329985e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 04:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788433349; x=1789038149; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=82nGEyjblHhHI3MrDMVBXgTcu8gABpUQwBchRyQe4V0=;
 b=Ca2z84Kt4pheztaZ3tqdTyUDwN6XWtZ+REqzRWcQtl3eGFjA4sKNTYu8mvpqs8Qtbi
 UX6LGfAr0R3zS1+6eC7/Wz+xSWRmDDVI9dA2emmgo2SKnYkbzPUvScUadCoEAmMpMxP9
 xgYDKONL4aaydPKDBzp8Rlx0dtlLpNzwAZptIgeuxiAibgSExDaDjrjY8VqxWem9QfQh
 DRrQdhz3p21XBTLurrCgN217MzWnqj03gpn8g7uTpIr9jdJXHZYs8T9Cx0lT53V89tfp
 KBifge+oaM188SoLHV/ZzT/G0469h1RpNyBCaqlF7OIeovXC8t3hXx8ilOxnzOBsjj3x
 l+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788433349; x=1789038149;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=82nGEyjblHhHI3MrDMVBXgTcu8gABpUQwBchRyQe4V0=;
 b=f2fA1/qnBxRwvvm0DDbFsxxCxDsiXYC7+4Le+m/C8CRim/41YBIyJin9w6nqj5s21B
 fl8quKab25otlGPb28pErTJ7+GxrcVn8apcTE63EfIuD0AbMz+O/Wf0YfJM/N57zxsK8
 ABmdkCFV9U7EUfq0Pt3g8Z8UF7i6cHfwD6phMuPLGfzj286Clr3lk/1HkmTGSrN0jiDS
 FOXpCVHZq2jm2cmVOrTfKfI3lnem2LUKkgYuUU9P4e4/WAaZuvqoQExK9YN85+43Sz0z
 ruz44f8BqOjpu9iqdB8Uvi6LlF6vN4lDPUX+LCJZ+yTY8sZ80QXXsMV3cDaMU4XkLP2F
 uavg==
X-Gm-Message-State: AFuF++nwDTsH5c87TWSn+uHDMdRHhJer/IPliRhQGKTifLXsR20os16x
 rwemBctT0jzPtycWzOFTQ+rhj/UstdH0QkeCFTnGh0pFiUAKJO5GyDHFKqXwSlOSU2IWGtg329B
 BAOvwibHmqCLHwQMu/1mSz9zFYfjeO+VwaXs5TlSq2YJdFYA9PEmyK3da
X-Gm-Gg: AYBFou28jIoZIhTkWkS7aR60KxA3u7tWtjkH376jojP+41xOQibGdSaDYgV/A+6XsXb
 YJK2K0qRqqbfKU8mbA7T+TzTXrg428CGTG77VkRUP+TRD7aaNAjXCszn7G6qcvcgt41HibtXUmA
 baSvt0zOvhDTrGZ6fXaQWYn6mprPAFlQvMCv6y5GWCVxzkydO25w4vPxCiT4ZTKUMqWIs/EIjxo
 l/DEE1Oysiax5BxeK3n8cx2E1qPnYRx+5nLpyUvEtliUoRGVgYhrod6CL3sdrs9Y/Gy9MIBgZTx
 4ZgFBPgSawboc9SFzS98TheRqvVnBUJlo9K6CQlNo6Zb9a7Zg4+HRfNQBVY1TYYaG3m4LXcLBGw
 i3qzIwlR2n+4MLogS9noFzpeq5z9oQO0KcoA=
X-Received: by 2002:a05:600c:1385:b0:499:83f1:398 with SMTP id
 5b1f17b1804b1-49ce583e8c8mr187091715e9.9.1788433348880; 
 Thu, 03 Sep 2026 04:02:28 -0700 (PDT)
X-Received: by 2002:a05:600c:1385:b0:499:83f1:398 with SMTP id
 5b1f17b1804b1-49ce583e8c8mr187091045e9.9.1788433348416; 
 Thu, 03 Sep 2026 04:02:28 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d4938sm62531375e9.2.2026.09.03.04.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 04:02:20 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:02:17 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
Message-ID: <aplQKjieyMHUoCWs@leonardi-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
 <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
 <apk1djopa9z3tfYR@leonardi-redhat>
 <CEF80B59-E81A-4B97-87E5-9087FAF3680B@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CEF80B59-E81A-4B97-87E5-9087FAF3680B@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 03, 2026 at 03:33:30PM +0530, Ani Sinha wrote:
>
>
>> On 3 Sep 2026, at 2:31 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
>>
>> Hi Ani,
>>
>> On Thu, Sep 03, 2026 at 02:16:30PM +0530, Ani Sinha wrote:
>>>
>>>
>>>> On 1 Sep 2026, at 3:39 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
>>>>
>>>> The guest policy carried in the IGVM guest-policy initialization header
>>>> was parsed into QIgvm but never forwarded to the confidential guest
>>>> platform: the previous callback ran at the end of qigvm_process_file,
>>>> after LAUNCH_START had already been issued, so writing the policy had
>>>> no effect.
>>>>
>>>> Add a set_guest_policy callback and invoke it from the guest-policy
>>>> initialization handler, so the policy reaches the platform before
>>>> LAUNCH_START.
>>>>
>>>> The guest policy can also be set on the command line. As it is part of
>>>> the attestation report, silently overriding it would cause attestation
>>>> to fail, so return an error if the command-line value differs from the
>>>> one supplied by the IGVM file.
>>>>
>>>> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
>>>> Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
>>>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>> ---
>>>> backends/confidential-guest-support.c |  9 ++++++++
>>>> backends/igvm.c                       |  4 ++++
>>>> target/i386/sev.c                     | 39 +++++++++++++++++++++++++++++++++++
>>>> 3 files changed, 52 insertions(+)
>>>>
>>>> diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>>>> index a0b36d2da5..c0d15b4a76 100644
>>>> --- a/backends/confidential-guest-support.c
>>>> +++ b/backends/confidential-guest-support.c
>>>> @@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>>>>    return -1;
>>>> }
>>>>
>>>> +static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
>>>> +                            uint64_t policy, Error **errp)
>>>> +{
>>>> +    error_setg(errp,
>>>> +               "Setting guest policy is not supported for this platform");
>>>> +    return -1;
>>>> +}
>>>> +
>>>> static int set_id_block(void *id_block, uint32_t id_block_size,
>>>>                        void *id_auth, uint32_t id_auth_size,
>>>>                        Error **errp)
>>>> @@ -62,6 +70,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
>>>>    ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>>>>    cgsc->check_support = check_support;
>>>>    cgsc->set_guest_state = set_guest_state;
>>>> +    cgsc->set_guest_policy = set_guest_policy;
>>>>    cgsc->set_id_block = set_id_block;
>>>>    cgsc->get_mem_map_entry = get_mem_map_entry;
>>>> }
>>>> diff --git a/backends/igvm.c b/backends/igvm.c
>>>> index 6545382546..5131ee7829 100644
>>>> --- a/backends/igvm.c
>>>> +++ b/backends/igvm.c
>>>> @@ -868,6 +868,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
>>>>
>>>>    if (guest->compatibility_mask & ctx->compatibility_mask) {
>>>>        ctx->sev_policy = guest->policy;
>>>> +        if (ctx->cgsc) {
>>>> +            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
>>>> +                                               guest->policy, errp);
>>>> +        }
>>>>    }
>>>>    return 0;
>>>> }
>>>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>>>> index c76cdba8d2..533ea4b54e 100644
>>>> --- a/target/i386/sev.c
>>>> +++ b/target/i386/sev.c
>>>> @@ -128,6 +128,8 @@ struct SevCommonState {
>>>>    bool kernel_hashes;
>>>>    uint64_t sev_features;
>>>>    uint64_t supported_sev_features;
>>>> +    /* whether the guest policy was explicitly set on the command line */
>>>> +    bool policy_set;
>>>>
>>>>    /* runtime state */
>>>>    uint8_t api_major;
>>>> @@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
>>>>    return 0;
>>>> }
>>>>
>>>> +static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
>>>> +                                uint64_t policy, Error **errp)
>>>> +{
>>>> +    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>>>> +
>>>> +    if (policy_type != GUEST_POLICY_SEV) {
>>>> +        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
>>>> +                   policy_type);
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    if (sev_snp_enabled()) {
>>>> +        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
>>>> +
>>>> +        if (sev_common->policy_set &&
>>>> +            sev_snp_guest->kvm_start_conf.policy != policy) {
>>>> +            error_setg(errp, "SNP: policy mismatch between IGVM and CLI");
>>>> +            return -1;
>>>> +        }
>>>> +
>>>> +        sev_snp_guest->kvm_start_conf.policy = policy;
>>
>> Thanks for you review!
>>
>>>
>>> I had fixed a bug initially here where we need to check if the policy passed is not 0. I am not sure if that fix is still needed here.
>>> Please test this scenario:
>>> a) Generate an IGVM file with policy set to 0.
>>
>> 0 is not a valid sev-snp guest policy: bit 17 is reserved and must be 1.
>> It's a valid sev/sev-es policy though.
>>
>>> b) Start a confidential SEV-SNP guest with policy set in command line and with this IGVM.
>>> I think with your patch this will fail as the policies won’t match.
>>
>> Correct: this was suggested by Gerd, as this is something unexpected. I
>> think it would break launch measurement.
>
>Yes I think the right thing to do is that if the policy is correctly set by IGVM, override the one set in the cli with the one in IGVM. Otherwise ignore IGVM policy.
>

mmh why? I might be missing something, but for now I'm not really convinced:
if we have a policy set in IGVM we should use that one. Overriding it using the
CLI, may cause measurement failure. If we have an IGVM image with a wrong policy
set, then the problem should be fixed there.

@Gerd @Stefano WDYT?

Luigi


