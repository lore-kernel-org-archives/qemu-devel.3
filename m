Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FDBC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27Uo-00062Q-H7; Thu, 03 Sep 2026 09:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x27Ui-00061N-T0
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x27Uf-0003BA-ST
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788442119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1YQDulG6r6hFOLVcE9RErPq4iQ9rHI7teEokaBs1pM=;
 b=LneeJzami4lhGP0wb4bsJxLg69um3hfVyD+67F7tsfiZhHF6rQIqeOX1ZaPsgEakxfczWy
 SvPAB6ldz1ckWr707EZnaFp1106CQlr+ql5p58AFIn1aAYIw/AWGm388UAkghflStMWLH6
 zlhAtCSZYHJNOOGERV52tsqHlXxcbkE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-dhX70PPtNouk9d1NGuMIWQ-1; Thu, 03 Sep 2026 09:28:38 -0400
X-MC-Unique: dhX70PPtNouk9d1NGuMIWQ-1
X-Mimecast-MFC-AGG-ID: dhX70PPtNouk9d1NGuMIWQ_1788442117
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-484362cb000so711361f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788442117; x=1789046917; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c1YQDulG6r6hFOLVcE9RErPq4iQ9rHI7teEokaBs1pM=;
 b=T60ZgQvYQunFhg8ae3GFJUF8ZCZ8FpAo/AKMEkpOspforPsKxXAwYlwSSj8mUL779N
 bnyyq87UamU0HM9/zP5gjkmmJQzuzTeaOkebhaVHy7qFsq8OCO16ICX8NnRKfh92SdmK
 +LFzAWtKkY3CpAihfqCq+k8DibpzyDE5/iYtneR3siNtgmIGiEiihQ8SzvELi11TJNX6
 AxXFIav0nl5VuqQOcgT3pwY5uHyRknQWcBgz5fL9oITbYUDKsMKaOF9HPs4yW9qxhuJj
 GGbhtKojBgNDcBP8bR1Hg7nBbTFV6tqLi7PdkONKQo9tJAnsm1TvsJj4N4HZrgZqjdkc
 IkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788442117; x=1789046917;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c1YQDulG6r6hFOLVcE9RErPq4iQ9rHI7teEokaBs1pM=;
 b=TzJPMVIdc5zgyutNoyQ1/xjmsbEjyvOn787rwgZzKRlfVKiQnXtPPuVdLQj4sIfaeM
 ibrpGBQUYAbBuNl+BLLdATnOBPJ48AnMuqi7E8Dfcjxv1/h/gy19YpLMNkEF2Cp2Wsp/
 zwGugA2PbgAbG3CV+3rph64HuzKk78Bn1l7zpxlYqc0JglvnaV1W8TLzQmL0ZS0rxXyM
 3CH7+tt6Fx0vgAeZcsuKa2hmdFzSlIYktpS3lE6QlzMiFivx+Lio/hFfeStP70QL73Yh
 vE/uV2MVNt2KYvSC0Zi6dVcX7y5fqTYRBVqzg6gk7++0gdKG5tWNS6v8lTiU7xjKqU7G
 S9EQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByMI2oSINp2qNWRiIFN6ELaqCSqmAs9xZTlUo1uKuwm/r3B0QcI47kIG6/z+FBI6HNWRnatgGRSWn2p@nongnu.org
X-Gm-Message-State: AFuF++mQkBEF1N5WvBN0/opr/WWlT85ej4a8Yl32wfp7XZyVzQR3VaAD
 XFc3sp3QwBQw1sgaEHZjzeA9ODRnRycP4glCGdtgeWtYoZMcw0T2CyiXRJX78gR5zZoHf/A/qbF
 CMr/bdUFPsOZKMbmGAEglM0DTBaMInt29Ol08TmsIii4JeVMunC5aKdS4
X-Gm-Gg: AYBFou20irWUGe1QQKgA5JJMO7AXJvA9j0pPK7D+mSiWIJWxZ0tAsrtYchGjOGl+Oai
 kiB+C6q1q4i3QgvoJ0WtImxrgoj1ublSrsUsrumJRPONvnjBt+aB9n1iOI8Uei+Vm4yR/bKzcV+
 EIQAGOM5KdMqEdZfp6eHogrl1GFU7uEIPjpn7Vtyw0TI2wqmXTxePtrPeR0r38vJEjamMFMI7nY
 6MfUkn1femQo9YzWRuFYaeYQ5iZLBn4rLrAM/b81rcDCzlfohEOUs7G88mJnRgiJ9wIZ6wSuSds
 rOtt5njwK0WkT/dhoNazZ/eAHnbtz6iAOy49LKe//1Ha+5q+jtUrUMgkGnXz+0iAx6BIzvKFzpZ
 JaJ4qFl7CbcXHJraQQAqCWnpN4x7bhrR7bWGn0HsGfQ4g/Q==
X-Received: by 2002:a05:6000:bc2:b0:484:4779:bcd6 with SMTP id
 ffacd0b85a97d-4857e63715fmr6630040f8f.15.1788442117052; 
 Thu, 03 Sep 2026 06:28:37 -0700 (PDT)
X-Received: by 2002:a05:6000:bc2:b0:484:4779:bcd6 with SMTP id
 ffacd0b85a97d-4857e63715fmr6629977f8f.15.1788442116445; 
 Thu, 03 Sep 2026 06:28:36 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492ce236sm16215287f8f.35.2026.09.03.06.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:28:35 -0700 (PDT)
Date: Thu, 3 Sep 2026 15:28:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Luigi Leonardi <leonardi@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
Message-ID: <aplz6Wvb-IhgUJ59@sgarzare-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
 <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
 <apk1djopa9z3tfYR@leonardi-redhat>
 <CEF80B59-E81A-4B97-87E5-9087FAF3680B@redhat.com>
 <aplQKjieyMHUoCWs@leonardi-redhat> <aplfB4L_WoFdpeBD@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aplfB4L_WoFdpeBD@redhat.com>
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

On Thu, Sep 03, 2026 at 12:50:31PM +0100, Daniel P. Berrangé wrote:
>On Thu, Sep 03, 2026 at 01:02:17PM +0200, Luigi Leonardi wrote:
>> On Thu, Sep 03, 2026 at 03:33:30PM +0530, Ani Sinha wrote:
>> >
>> >
>> > > On 3 Sep 2026, at 2:31 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
>> > >
>> > > Hi Ani,
>> > >
>> > > On Thu, Sep 03, 2026 at 02:16:30PM +0530, Ani Sinha wrote:
>> > > >
>> > > >
>> > > > > On 1 Sep 2026, at 3:39 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
>> > > > >
>> > > > > The guest policy carried in the IGVM guest-policy initialization header
>> > > > > was parsed into QIgvm but never forwarded to the confidential guest
>> > > > > platform: the previous callback ran at the end of qigvm_process_file,
>> > > > > after LAUNCH_START had already been issued, so writing the policy had
>> > > > > no effect.
>> > > > >
>> > > > > Add a set_guest_policy callback and invoke it from the guest-policy
>> > > > > initialization handler, so the policy reaches the platform before
>> > > > > LAUNCH_START.
>> > > > >
>> > > > > The guest policy can also be set on the command line. As it is part of
>> > > > > the attestation report, silently overriding it would cause attestation
>> > > > > to fail, so return an error if the command-line value differs from the
>> > > > > one supplied by the IGVM file.
>> > > > >
>> > > > > Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
>> > > > > Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
>> > > > > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>> > > > > ---
>> > > > > backends/confidential-guest-support.c |  9 ++++++++
>> > > > > backends/igvm.c                       |  4 ++++
>> > > > > target/i386/sev.c                     | 39 +++++++++++++++++++++++++++++++++++
>> > > > > 3 files changed, 52 insertions(+)
>> > > > >
>> > > > > diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>> > > > > index a0b36d2da5..c0d15b4a76 100644
>> > > > > --- a/backends/confidential-guest-support.c
>> > > > > +++ b/backends/confidential-guest-support.c
>> > > > > @@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>> > > > >    return -1;
>> > > > > }
>> > > > >
>> > > > > +static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
>> > > > > +                            uint64_t policy, Error **errp)
>> > > > > +{
>> > > > > +    error_setg(errp,
>> > > > > +               "Setting guest policy is not supported for this platform");
>> > > > > +    return -1;
>> > > > > +}
>> > > > > +
>> > > > > static int set_id_block(void *id_block, uint32_t id_block_size,
>> > > > >                        void *id_auth, uint32_t id_auth_size,
>> > > > >                        Error **errp)
>> > > > > @@ -62,6 +70,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
>> > > > >    ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>> > > > >    cgsc->check_support = check_support;
>> > > > >    cgsc->set_guest_state = set_guest_state;
>> > > > > +    cgsc->set_guest_policy = set_guest_policy;
>> > > > >    cgsc->set_id_block = set_id_block;
>> > > > >    cgsc->get_mem_map_entry = get_mem_map_entry;
>> > > > > }
>> > > > > diff --git a/backends/igvm.c b/backends/igvm.c
>> > > > > index 6545382546..5131ee7829 100644
>> > > > > --- a/backends/igvm.c
>> > > > > +++ b/backends/igvm.c
>> > > > > @@ -868,6 +868,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
>> > > > >
>> > > > >    if (guest->compatibility_mask & ctx->compatibility_mask) {
>> > > > >        ctx->sev_policy = guest->policy;
>> > > > > +        if (ctx->cgsc) {
>> > > > > +            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
>> > > > > +                                               guest->policy, errp);
>> > > > > +        }
>> > > > >    }
>> > > > >    return 0;
>> > > > > }
>> > > > > diff --git a/target/i386/sev.c b/target/i386/sev.c
>> > > > > index c76cdba8d2..533ea4b54e 100644
>> > > > > --- a/target/i386/sev.c
>> > > > > +++ b/target/i386/sev.c
>> > > > > @@ -128,6 +128,8 @@ struct SevCommonState {
>> > > > >    bool kernel_hashes;
>> > > > >    uint64_t sev_features;
>> > > > >    uint64_t supported_sev_features;
>> > > > > +    /* whether the guest policy was explicitly set on the command line */
>> > > > > +    bool policy_set;
>> > > > >
>> > > > >    /* runtime state */
>> > > > >    uint8_t api_major;
>> > > > > @@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
>> > > > >    return 0;
>> > > > > }
>> > > > >
>> > > > > +static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
>> > > > > +                                uint64_t policy, Error **errp)
>> > > > > +{
>> > > > > +    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>> > > > > +
>> > > > > +    if (policy_type != GUEST_POLICY_SEV) {
>> > > > > +        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
>> > > > > +                   policy_type);
>> > > > > +        return -1;
>> > > > > +    }
>> > > > > +
>> > > > > +    if (sev_snp_enabled()) {
>> > > > > +        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
>> > > > > +
>> > > > > +        if (sev_common->policy_set &&
>> > > > > +            sev_snp_guest->kvm_start_conf.policy != policy) {
>> > > > > +            error_setg(errp, "SNP: policy mismatch between IGVM and CLI");
>> > > > > +            return -1;
>> > > > > +        }
>> > > > > +
>> > > > > +        sev_snp_guest->kvm_start_conf.policy = policy;
>> > >
>> > > Thanks for you review!
>> > >
>> > > >
>> > > > I had fixed a bug initially here where we need to check if the policy passed is not 0. I am not sure if that fix is still needed here.
>> > > > Please test this scenario:
>> > > > a) Generate an IGVM file with policy set to 0.
>> > >
>> > > 0 is not a valid sev-snp guest policy: bit 17 is reserved and must be 1.
>> > > It's a valid sev/sev-es policy though.
>> > >
>> > > > b) Start a confidential SEV-SNP guest with policy set in command line and with this IGVM.
>> > > > I think with your patch this will fail as the policies won’t match.
>> > >
>> > > Correct: this was suggested by Gerd, as this is something unexpected. I
>> > > think it would break launch measurement.
>> >
>> > Yes I think the right thing to do is that if the policy is correctly set by IGVM, override the one set in the cli with the one in IGVM. Otherwise ignore IGVM policy.
>
>As a general rule, if the user passes a parameter to QEMU, it should
>always either be honoured, or result in an error. Selectively ignoring
>user input has proved to be a generally bad idea, as it tends to mask
>user configuration mistakes.
>
>> mmh why? I might be missing something, but for now I'm not really convinced:
>> if we have a policy set in IGVM we should use that one. Overriding it using the
>> CLI, may cause measurement failure. If we have an IGVM image with a wrong policy
>> set, then the problem should be fixed there.
>
>If the user choose to override policy on the CLI, isn't it now just
>their problem to also figure out what the new expected measurement
>will be ?
>
>Why wouldn't we just honour the IGVM by default, and if the CLI
>has further customizations let them override the IGVM, and leave
>the user to figure out the implications.

I also slightly prefer this behaviour too, I see some advantages, 
especially for testing and debugging, where you don't want to regenerate 
the IGVM. But I don't have a strong opinion on this; if there is a 
mismatch, though, I agree that it's better to get an error than to 
ignore the CLI.

Thanks,
Stefano


