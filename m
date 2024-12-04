Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815E6E77171
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIul9-0003ev-73; Wed, 04 Dec 2024 14:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tIul7-0003eG-Rc
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:10:01 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tIul6-0005Y0-5q
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:10:01 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4349fb56260so923655e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 11:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733339398; x=1733944198; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bOngM2USHeFq8uTvg6lBb0tN7fu7f0bTGVR8zQJEEB8=;
 b=DcCiGni88u8hA8+4CL5sfQ0s+5VF7+SQxWR+YJrXAzJc+3PPKkvUGKM6xW6sYK5IK+
 JMG2yOroYlSWkgsQGQ06crBlUBSqbiG2fSWa5ANBRu26sWju7KjCsnIBcOaqISi9i94x
 H59/XLlBdz6VjFqkLYKY0DmqMSaCNAwk8V/35fHr4oh+nPTXW7QSw7O7I67P+oX/SkYb
 IYzJVdB8vl8+LAj9rWU7O3arW6s2sGrzeSo7b00cgRxU5z249kAAilkzDo/F01SXHgxg
 szRfWr1t2yUjH+qsHbhf+8pQJwZhj1r1CoNMHSSntJAIci+W7RCuMVN9x8Ul6A0Sh+dl
 tixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733339398; x=1733944198;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOngM2USHeFq8uTvg6lBb0tN7fu7f0bTGVR8zQJEEB8=;
 b=XlvCeW2mib+si4HDNQZ5FGx1GNAo7w0VMMQ+2wA0RVW93ve67kVofJJaNCtZW4gpCw
 MjmU7aGEoGPDmWbcgW6kfzHM20zcKwyd7G4tUNgGYa3VlFucFsnGnBqO/C0yv4nQHjEX
 7gAbB8aNz225jT01/yeQdQVIvsTddchfrmVOqjXr2OA6BxTJdK9Em1rNjdguLXjK2mq8
 mY96fPQJDSOrvL3Yy95y9p3OSyx5/fbxRPktAzYpcpUQz5S5P8ooSWRp+YwTGQ54QAHy
 W7LJR+8vodibfvuyY1FGFEDE+mB73Nc9hrJNInmmIac+McwFR44U7qUuPhuc7wAcAvVT
 GbLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRoIF7UP61+zR/jpjTLulwMlm+LbWbVQqWYEM/q0+EPpZc3oY81FqVo2nu3ngzDQ2FnZ9J2SX6Xt2Y@nongnu.org
X-Gm-Message-State: AOJu0YwCQXGti52i6BwscQbTVRe4RLs5rQEWaNx1O0MxwKY/YbJUNZ03
 FZoC85wBrTE0M2UnSSrNbBlKNQ54WHDF+LVj0DlKmRhZBwhVGo8zSaOFII8hdwg=
X-Gm-Gg: ASbGncutEmWzjyzXkX7aIwF0AnEXVRF6Ws5S31KkZCKfp2znJl/9WCF7dO0VHpwpoC1
 VZ7YPF3tO10BtabM/SrhNjxJvcCOaE0XgSphPUiPWdCqzeA1PNpQ5lv8exRqcBz5wvkAYAVi7AX
 CzyfVxnnLhIXI2ttTl+oKSyIvHdohLeSxvJ1tH5JfW0GPG81kCPRZ8X54SU5XC3Ae8Z78M2Uzlz
 +LSYrXpPskfVEjUuMpUiYqwN4YvVy+tfOSNnNk86FVjD1nU
X-Google-Smtp-Source: AGHT+IEysxLskTX7ub6F4QI9uApjoI3rJA+U0novnGuunCkTE/hNmntYybCKTu+FYjbWjcabq6TTBw==
X-Received: by 2002:a05:6000:2a85:b0:382:49f9:74bb with SMTP id
 ffacd0b85a97d-385fd3f92f8mr5259423f8f.35.1733339397938; 
 Wed, 04 Dec 2024 11:09:57 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e5b10478sm13531553f8f.73.2024.12.04.11.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 11:09:57 -0800 (PST)
Date: Wed, 4 Dec 2024 19:10:16 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, Eric Blake <eblake@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 10/26] target/arm/kvm-rme: Add Realm Personalization
 Value parameter
Message-ID: <20241204191016.GC2349278@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-12-jean-philippe@linaro.org>
 <87wmgqsbp1.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmgqsbp1.fsf@pond.sub.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 26, 2024 at 08:20:42AM +0100, Markus Armbruster wrote:
> > +# @personalization-value: Realm personalization value, as a 64-byte
> > +#     hex string. This optional parameter allows to uniquely identify
> > +#     the VM instance during attestation. (default: 0)
> 
> QMP commonly uses base64 for encoding binary data.  Any particular
> reason to deviate?

No, I think base64 is fine for this

> 
> Is the "hex string" to be mapped to binary in little or big endian?  Not
> an issue with base64.

(It was big endian with padding on the right)

> 
> Nitpick: (default: all-zero), please, for consistency with similar
> documentation in SevSnpGuestProperties.
> 
> > +#
> > +# Since: 9.3
> > +##
> > +{ 'struct': 'RmeGuestProperties',
> > +  'data': { '*personalization-value': 'str' } }
> >  
> >  ##
> >  # @ObjectType:
> > @@ -1121,6 +1134,7 @@
> >      { 'name': 'pr-manager-helper',
> >        'if': 'CONFIG_LINUX' },
> >      'qtest',
> > +    'rme-guest',
> >      'rng-builtin',
> >      'rng-egd',
> >      { 'name': 'rng-random',
> 
> The commit message claims the patch adds a parameter.  It actually adds
> an entire object type.

Yes as Daniel noted this belongs in an earlier patch

> 
> > @@ -1195,6 +1209,7 @@
> >        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> >                                        'if': 'CONFIG_LINUX' },
> >        'qtest':                      'QtestProperties',
> > +      'rme-guest':                  'RmeGuestProperties',
> >        'rng-builtin':                'RngProperties',
> >        'rng-egd':                    'RngEgdProperties',
> >        'rng-random':                 { 'type': 'RngRandomProperties',
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index 83a29421df..0be55867ee 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -23,11 +23,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> >  
> >  #define RME_PAGE_SIZE qemu_real_host_page_size()
> >  
> > +#define RME_MAX_CFG         1
> > +
> >  struct RmeGuest {
> >      ConfidentialGuestSupport parent_obj;
> >      Notifier rom_load_notifier;
> >      GSList *ram_regions;
> >  
> > +    uint8_t *personalization_value;
> > +
> >      hwaddr ram_base;
> >      size_t ram_size;
> >  };
> > @@ -43,6 +47,48 @@ typedef struct {
> >  
> >  static RmeGuest *rme_guest;
> >  
> > +static int rme_configure_one(RmeGuest *guest, uint32_t cfg, Error **errp)
> > +{
> > +    int ret;
> > +    const char *cfg_str;
> > +    struct kvm_cap_arm_rme_config_item args = {
> > +        .cfg = cfg,
> > +    };
> > +
> > +    switch (cfg) {
> > +    case KVM_CAP_ARM_RME_CFG_RPV:
> > +        if (!guest->personalization_value) {
> > +            return 0;
> > +        }
> > +        memcpy(args.rpv, guest->personalization_value, KVM_CAP_ARM_RME_RPV_SIZE);
> > +        cfg_str = "personalization value";
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> 
> This function gets called with @cfg arguments 0 .. RME_MAX_CFG-1, from
> rme_configure() right below.  RME_MAX_CFG is defined to 1 above.
> 
> The switch assumes KVM_CAP_ARM_RME_CFG_RPV is zero.  Such assumptions
> are ideally avoided, and alternatively checked at build time.

Ok, I'll change this

Thanks,
Jean

