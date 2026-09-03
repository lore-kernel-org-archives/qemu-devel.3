Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636CFC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27gi-0001vS-NL; Thu, 03 Sep 2026 09:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x27gh-0001vA-Ep
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x27gf-0004kj-4m
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788442863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8x6S+9/rnrnEQ8TizwcXd1P0Fsb5Qz8XY4KENCYeYjs=;
 b=PqqgL+zFMSMbZPx1xXpc2TcmKRfxL/s3Y9TwwRIjja8NjQg0EEHhQLYtblJOdUZ0lqP9Mx
 3USk8Cu6WF+C6XS7Wx5OQqAoN+DlTG3iunObvku/gMpgsJ1xakzVI1Kn1hpXkkAbXKP82u
 e0nQhcn6U8itC4BDL+tO54811hP+N7M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-tMoG5f3DNLivNlBYDkCirA-1; Thu, 03 Sep 2026 09:41:02 -0400
X-MC-Unique: tMoG5f3DNLivNlBYDkCirA-1
X-Mimecast-MFC-AGG-ID: tMoG5f3DNLivNlBYDkCirA_1788442861
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49ccf17d3b0so15417605e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788442861; x=1789047661; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8x6S+9/rnrnEQ8TizwcXd1P0Fsb5Qz8XY4KENCYeYjs=;
 b=sDchEF9fTs1RxLDO8VIqlLH4pt+fjlAp2KWwCcvx0lWathOOhCf0gyG4byrdujYZq/
 r9tw8Th0zeV/VPuNvIVPRkp0N6hK/k4frEec1UGOEz1UM4FsVABP5kMA8Q+aKADBuI8I
 Vk9OCuAGA8zofnTHHGm1uB4a4Eyo773DS1DFYfuEq+FdkUSLRgisRtzFT9lFa1EDMCAy
 Ltl/QsWCkqzmVLQOGmP9hm0jQ3MdrazCg/a31gavr1/q7xC3ZMkKTVOza6+JOzTmzrpO
 VNka5jqkOfdLgKN9Nyj9P+H3nFTg0lQyxPih7fmjsqD1afIQL8p0DzV5+ZYiSIGziN0j
 4Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788442861; x=1789047661;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8x6S+9/rnrnEQ8TizwcXd1P0Fsb5Qz8XY4KENCYeYjs=;
 b=lyQ777VR5ZpnmrdNTBunbL2mbNdGOCmEOlsOt+i3P8v9sXY6jaKzsZMlQ8UVFW6G9P
 e70nCZ402QlGP89FFdhVpBwEMZZXcSw0JlZ4/ol0cF+fY0xgBh3RJCz2nig5z24zhXrF
 RFdkJ9iGmrBL+RPeI+lTYYL8ZfNAPJ+UdEAymFsSlAEtkJSAEVm7SE+V8+pY5Ubdqd9X
 KydYnlzZWZ8meyVpSRvMz7AwdaC3cdL8C0PKW6j5Ra45DlRTFaKkuwiobGQifRhjTfkx
 pWvVMglldX3ePHtOmeC381DqCFR23AA3WOvNeiHEyZpkDvRuuQ3EFMgIazy4bnHVAtYi
 E80A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFZUJrMDv7rlU4W/Agta19rNOj63IBqZ40LUkDX/YFFsk98GeN6vHYmz91e/+/QNYF7tU65OyYTohB@nongnu.org
X-Gm-Message-State: AFuF++kF3FF9SMWvzZF8EDY18/8Dk246La78Si/X2bYRRYwF5vtNsTCp
 +A4Z2pgVIU+ez1n69fnZvjo+1caTSHWIFK4VX/1Oywa1VFEA9kUMBalIU3siFB203lMbYZ2k9NU
 li+IiWVi9UybTRuAR0nzjlJPlI92lmG/h0MPXGX1HDRR3gsHNFFFC12wg
X-Gm-Gg: AYBFou3wBv9eSv+aGo9j9Q6EU11eTaO+51W+ok4FBUvwR7CJUHHBh5iIuQQdmsO3Uda
 SwhMASe9sP9Yaj4xar1adhHMRtFmJ+09lCuAtoeh+mxyQB3dmA92Yi4zd/3TWBzXC/aXQpiLiCL
 4L295ugZGfpK+gP28UIOqiQRt0sSZ0pG8D0qXCz9YKXp2vDIV02jZiYy+ccCCs7wHPH34Ldm8+V
 F2b04/ubO2niZ7cDRQFdPz1sPX6fmSDLxzl9YfM87M+uZ7KVSE0KIvnHvD45s4msBzPxGoVMPEV
 yJuNJ6tuHO+03lR589r8bz9uUW7BmU6qjoFBF6L3ICcaQwMF2MxDB0JUT3nBwcAzyOQCXVhmcHw
 jvx3/96sZ6USWndFLIJpoetFCgM+2gubNS+A=
X-Received: by 2002:a05:600c:6209:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-49ce582039fmr236993405e9.7.1788442860962; 
 Thu, 03 Sep 2026 06:41:00 -0700 (PDT)
X-Received: by 2002:a05:600c:6209:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-49ce582039fmr236992585e9.7.1788442860569; 
 Thu, 03 Sep 2026 06:41:00 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60bae6sm88636585e9.9.2026.09.03.06.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:40:59 -0700 (PDT)
Date: Thu, 3 Sep 2026 15:40:57 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
Message-ID: <apl3wnsHORCNP4k-@leonardi-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
 <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
 <apk1djopa9z3tfYR@leonardi-redhat>
 <CEF80B59-E81A-4B97-87E5-9087FAF3680B@redhat.com>
 <aplQKjieyMHUoCWs@leonardi-redhat> <aplfB4L_WoFdpeBD@redhat.com>
 <aplz6Wvb-IhgUJ59@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aplz6Wvb-IhgUJ59@sgarzare-redhat>
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

On Thu, Sep 03, 2026 at 03:28:29PM +0200, Stefano Garzarella wrote:
>On Thu, Sep 03, 2026 at 12:50:31PM +0100, Daniel P. Berrangé wrote:
>>On Thu, Sep 03, 2026 at 01:02:17PM +0200, Luigi Leonardi wrote:
>>>On Thu, Sep 03, 2026 at 03:33:30PM +0530, Ani Sinha wrote:
>>>>
>>>>
>>>> > On 3 Sep 2026, at 2:31 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
>>>> >
>>>> > Hi Ani,
>>>> >
>>>> > On Thu, Sep 03, 2026 at 02:16:30PM +0530, Ani Sinha wrote:
>>>> > >
>>>> > >
>>>> > > > On 1 Sep 2026, at 3:39 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
>>>> > > >
>>>> > > > The guest policy carried in the IGVM guest-policy initialization header
>>>> > > > was parsed into QIgvm but never forwarded to the confidential guest
>>>> > > > platform: the previous callback ran at the end of qigvm_process_file,
>>>> > > > after LAUNCH_START had already been issued, so writing the policy had
>>>> > > > no effect.
>>>> > > >
>>>> > > > Add a set_guest_policy callback and invoke it from the guest-policy
>>>> > > > initialization handler, so the policy reaches the platform before
>>>> > > > LAUNCH_START.
>>>> > > >
>>>> > > > The guest policy can also be set on the command line. As it is part of
>>>> > > > the attestation report, silently overriding it would cause attestation
>>>> > > > to fail, so return an error if the command-line value differs from the
>>>> > > > one supplied by the IGVM file.
>>>> > > >
>>>> > > > Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
>>>> > > > Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
>>>> > > > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>> > > > ---
>>>> > > > backends/confidential-guest-support.c |  9 ++++++++
>>>> > > > backends/igvm.c                       |  4 ++++
>>>> > > > target/i386/sev.c                     | 39 +++++++++++++++++++++++++++++++++++
>>>> > > > 3 files changed, 52 insertions(+)
>>>> > > >
>>>> > > > diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>>>> > > > index a0b36d2da5..c0d15b4a76 100644
>>>> > > > --- a/backends/confidential-guest-support.c
>>>> > > > +++ b/backends/confidential-guest-support.c
>>>> > > > @@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>>>> > > >    return -1;
>>>> > > > }
>>>> > > >
>>>> > > > +static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
>>>> > > > +                            uint64_t policy, Error **errp)
>>>> > > > +{
>>>> > > > +    error_setg(errp,
>>>> > > > +               "Setting guest policy is not supported for this platform");
>>>> > > > +    return -1;
>>>> > > > +}
>>>> > > > +
>>>> > > > static int set_id_block(void *id_block, uint32_t id_block_size,
>>>> > > >                        void *id_auth, uint32_t id_auth_size,
>>>> > > >                        Error **errp)
>>>> > > > @@ -62,6 +70,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
>>>> > > >    ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>>>> > > >    cgsc->check_support = check_support;
>>>> > > >    cgsc->set_guest_state = set_guest_state;
>>>> > > > +    cgsc->set_guest_policy = set_guest_policy;
>>>> > > >    cgsc->set_id_block = set_id_block;
>>>> > > >    cgsc->get_mem_map_entry = get_mem_map_entry;
>>>> > > > }
>>>> > > > diff --git a/backends/igvm.c b/backends/igvm.c
>>>> > > > index 6545382546..5131ee7829 100644
>>>> > > > --- a/backends/igvm.c
>>>> > > > +++ b/backends/igvm.c
>>>> > > > @@ -868,6 +868,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
>>>> > > >
>>>> > > >    if (guest->compatibility_mask & ctx->compatibility_mask) {
>>>> > > >        ctx->sev_policy = guest->policy;
>>>> > > > +        if (ctx->cgsc) {
>>>> > > > +            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
>>>> > > > +                                               guest->policy, errp);
>>>> > > > +        }
>>>> > > >    }
>>>> > > >    return 0;
>>>> > > > }
>>>> > > > diff --git a/target/i386/sev.c b/target/i386/sev.c
>>>> > > > index c76cdba8d2..533ea4b54e 100644
>>>> > > > --- a/target/i386/sev.c
>>>> > > > +++ b/target/i386/sev.c
>>>> > > > @@ -128,6 +128,8 @@ struct SevCommonState {
>>>> > > >    bool kernel_hashes;
>>>> > > >    uint64_t sev_features;
>>>> > > >    uint64_t supported_sev_features;
>>>> > > > +    /* whether the guest policy was explicitly set on the command line */
>>>> > > > +    bool policy_set;
>>>> > > >
>>>> > > >    /* runtime state */
>>>> > > >    uint8_t api_major;
>>>> > > > @@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
>>>> > > >    return 0;
>>>> > > > }
>>>> > > >
>>>> > > > +static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
>>>> > > > +                                uint64_t policy, Error **errp)
>>>> > > > +{
>>>> > > > +    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>>>> > > > +
>>>> > > > +    if (policy_type != GUEST_POLICY_SEV) {
>>>> > > > +        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
>>>> > > > +                   policy_type);
>>>> > > > +        return -1;
>>>> > > > +    }
>>>> > > > +
>>>> > > > +    if (sev_snp_enabled()) {
>>>> > > > +        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
>>>> > > > +
>>>> > > > +        if (sev_common->policy_set &&
>>>> > > > +            sev_snp_guest->kvm_start_conf.policy != policy) {
>>>> > > > +            error_setg(errp, "SNP: policy mismatch between IGVM and CLI");
>>>> > > > +            return -1;
>>>> > > > +        }
>>>> > > > +
>>>> > > > +        sev_snp_guest->kvm_start_conf.policy = policy;
>>>> >
>>>> > Thanks for you review!
>>>> >
>>>> > >
>>>> > > I had fixed a bug initially here where we need to check if the policy passed is not 0. I am not sure if that fix is still needed here.
>>>> > > Please test this scenario:
>>>> > > a) Generate an IGVM file with policy set to 0.
>>>> >
>>>> > 0 is not a valid sev-snp guest policy: bit 17 is reserved and must be 1.
>>>> > It's a valid sev/sev-es policy though.
>>>> >
>>>> > > b) Start a confidential SEV-SNP guest with policy set in command line and with this IGVM.
>>>> > > I think with your patch this will fail as the policies won’t match.
>>>> >
>>>> > Correct: this was suggested by Gerd, as this is something unexpected. I
>>>> > think it would break launch measurement.
>>>>
>>>> Yes I think the right thing to do is that if the policy is correctly set by IGVM, override the one set in the cli with the one in IGVM. Otherwise ignore IGVM policy.
>>
>>As a general rule, if the user passes a parameter to QEMU, it should
>>always either be honoured, or result in an error. Selectively ignoring
>>user input has proved to be a generally bad idea, as it tends to mask
>>user configuration mistakes.
>>
>>>mmh why? I might be missing something, but for now I'm not really convinced:
>>>if we have a policy set in IGVM we should use that one. Overriding it using the
>>>CLI, may cause measurement failure. If we have an IGVM image with a wrong policy
>>>set, then the problem should be fixed there.
>>
>>If the user choose to override policy on the CLI, isn't it now just
>>their problem to also figure out what the new expected measurement
>>will be ?
>>
>>Why wouldn't we just honour the IGVM by default, and if the CLI
>>has further customizations let them override the IGVM, and leave
>>the user to figure out the implications.
>
>I also slightly prefer this behaviour too, I see some advantages, 
>especially for testing and debugging, where you don't want to 
>regenerate the IGVM. But I don't have a strong opinion on this; if 
>there is a mismatch, though, I agree that it's better to get an error 
>than to ignore the CLI.
>

In this series, if there is a mismatch between IGVM and CLI, QEMU returns an error.
Debugging sounds very reasonable to me, so I'm fine on letting the CLI override IGVM.

Luigi


