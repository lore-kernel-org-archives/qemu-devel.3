Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE5AE77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIumL-0004is-Nl; Wed, 04 Dec 2024 14:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tIumH-0004cB-SZ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:11:13 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tIum7-0005rm-Uj
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:11:06 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so906155e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 11:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733339462; x=1733944262; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xJkr6X6iGm4jU0kNLf3h/3QCpkTdenPRAEhvG0eZ02w=;
 b=ITK5e2PBBRaGu8xm6vJaMpKu0ffsq51NC65nkdMy1BsFCvXGvbAnTtC5yFCwM/Tn7R
 T81+Tp5TLHKvxLl7MBZleZpaqbX5nmIwj80ZLKiwGTQeIbbMCO/avSCAMuK8V82M5u+r
 WoiHyC6LyznzlU64QOj/8CgHLr80CqU+MuwdVS34JJaHJrNc9GCWcZK1MYuhumA4Q0Ml
 v29r4DHqeF67Ou66xp5v4OQEkhN69gNqXBNXGShNdjR9xGZCWky2G/d8XMs3ddJf5HRB
 17pV48yBq/Sj2HQKSYumthpsAp9PBNCc4nib/NsNBCRWtljIKXYApZ8RZeZ68YoqN7JT
 OeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733339462; x=1733944262;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xJkr6X6iGm4jU0kNLf3h/3QCpkTdenPRAEhvG0eZ02w=;
 b=CVv3J66VrI0I0BJyR+sp9pbd8tZE9TKAt3VQ539IHHyRUzGkXzqa17qKScBXyanXfJ
 hXqvXPbLBq+18SeBrNkRbp7gClizpXLVUpAmIVP9UB6PX7i0QMKn1wcl+Q+Idp8khGLI
 qdDpzONBU1BALy8XeyUvC0FE/FZLBjYxxvtzGSgjQYP+k/9lCZh6o3IToXks7ALzZHVo
 6Ux59Nqi6v0H74LGc+lwnklcyBCRPlGVYJiXDdaz3FAtC6u2sMoVDxluBQeAw0SM6hdn
 nhNEgkr28bQ/+RNOsk6P+A2SDP3XFcFeoc6yCYbxFkeCsR4atSleBo7316SEc3crrzZW
 eWlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNA0DVdgPhw72zACgHh8OnrSXi5GQhocTTFcmkzJ6JBAVd06aXP3h+ID7GNFVvUglUrDJ9FEmtAdT3@nongnu.org
X-Gm-Message-State: AOJu0YzAocaz4DJhuoQ98iiAfu5XT/2wcu7JmslqYjqcTudq6IBgb7vP
 dtNuKpWOVGsr9TH1Vl42sO6JQzIJ+CFLKBJWq52inyNTtK4wgZ+2KGfVWpddxD0=
X-Gm-Gg: ASbGnctF6kzxamoqhyMgUANoP+jmsDqSQQQT/MUHcJz8mBdz0b0gZ/9VwLj6/4azQBY
 aR3IwElLNWoB4u0sAcrt9X5uk0kmkMMXXiWbYIag7LKCVzr1pRr8vS4A3F4mp39lV9TRU5et15Y
 4ei9S8KIE3MFdB1G8rs2jsMioYB59nePNqw2WgFCzshZaZJzwkB8AWE3q+I6FaV//i4dUAq6Wa6
 Ma+f7OkOnZY8d+zvG+EV8xrEXsTlmA03LUCgvUx0Kyx7wZq
X-Google-Smtp-Source: AGHT+IFSE7EbJ7GAFFLFXXCfbtDYu0IPP92EWaIzpH84TAUFzF3WLmk7cmqpWzWQfvclNGQGSrizKw==
X-Received: by 2002:a5d:6c6d:0:b0:385:f984:2cbc with SMTP id
 ffacd0b85a97d-385fd3f2d32mr6248857f8f.34.1733339462119; 
 Wed, 04 Dec 2024 11:11:02 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52c0bfasm34420985e9.32.2024.12.04.11.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 11:11:01 -0800 (PST)
Date: Wed, 4 Dec 2024 19:11:25 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, peter.maydell@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 10/26] target/arm/kvm-rme: Add Realm Personalization
 Value parameter
Message-ID: <20241204191125.GD2349278@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-12-jean-philippe@linaro.org>
 <87wmgqsbp1.fsf@pond.sub.org> <Z0XDfyDWc3OZSoj0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0XDfyDWc3OZSoj0@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 26, 2024 at 12:47:59PM +0000, Daniel P. Berrangé wrote:
> On Tue, Nov 26, 2024 at 08:20:42AM +0100, Markus Armbruster wrote:
> > Jean-Philippe Brucker <jean-philippe@linaro.org> writes:
> > 
> > > The Realm Personalization Value (RPV) is provided by the user to
> > > distinguish Realms that have the same initial measurement.
> > >
> > > The user provides up to 64 hexadecimal bytes. They are stored into the
> > > RPV in the same order, zero-padded on the right.
> > >
> > > Cc: Eric Blake <eblake@redhat.com>
> > > Cc: Markus Armbruster <armbru@redhat.com>
> > > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > > Cc: Eduardo Habkost <eduardo@habkost.net>
> > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > ---
> > > v2->v3: Fix documentation
> > > ---
> > >  qapi/qom.json        |  15 ++++++
> > >  target/arm/kvm-rme.c | 111 +++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 126 insertions(+)
> > >
> > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > index a8beeabf1f..f982850bca 100644
> > > --- a/qapi/qom.json
> > > +++ b/qapi/qom.json
> > > @@ -1068,6 +1068,19 @@
> > >    'data': { '*cpu-affinity': ['uint16'],
> > >              '*node-affinity': ['uint16'] } }
> > >  
> > > +##
> > > +# @RmeGuestProperties:
> > > +#
> > > +# Properties for rme-guest objects.
> > > +#
> > > +# @personalization-value: Realm personalization value, as a 64-byte
> > > +#     hex string. This optional parameter allows to uniquely identify
> > > +#     the VM instance during attestation. (default: 0)
> > 
> > QMP commonly uses base64 for encoding binary data.  Any particular
> > reason to deviate?
> > 
> > Is the "hex string" to be mapped to binary in little or big endian?  Not
> > an issue with base64.
> 
> Agreed, using base64 is preferrable for consistency.

Ack

> 
> > 
> > Nitpick: (default: all-zero), please, for consistency with similar
> > documentation in SevSnpGuestProperties.
> > 
> > > +#
> > > +# Since: 9.3
> 
> There is never any x.3 version of QEMU, as we bump the major
> version once a year. IOW, next release you could target this
> for will be 10.0

Ok good to know

Thanks,
Jean

> 
> > > +##
> > > +{ 'struct': 'RmeGuestProperties',
> > > +  'data': { '*personalization-value': 'str' } }
> > >  
> > >  ##
> > >  # @ObjectType:
> > > @@ -1121,6 +1134,7 @@
> > >      { 'name': 'pr-manager-helper',
> > >        'if': 'CONFIG_LINUX' },
> > >      'qtest',
> > > +    'rme-guest',
> > >      'rng-builtin',
> > >      'rng-egd',
> > >      { 'name': 'rng-random',
> > 
> > The commit message claims the patch adds a parameter.  It actually adds
> > an entire object type.
> 
> The object should be added to qom.json earlier in this series when
> the RmeGuest class is defined, then this patch would merely be adding
> the parameter.
> 
> > 
> > > @@ -1195,6 +1209,7 @@
> > >        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > >                                        'if': 'CONFIG_LINUX' },
> > >        'qtest':                      'QtestProperties',
> > > +      'rme-guest':                  'RmeGuestProperties',
> > >        'rng-builtin':                'RngProperties',
> > >        'rng-egd':                    'RngEgdProperties',
> > >        'rng-random':                 { 'type': 'RngRandomProperties',
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

