Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EEAFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI0ay-0000HZ-2d; Wed, 29 Apr 2026 04:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wI0au-0000Bs-AE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wI0as-000359-1S
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777452508;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3xPm3uk4GzUVgYO/3ToxqhNt6kEYKRWKRamKVfR0wUM=;
 b=CsNWUpS2h/TegsuUi5pRR4wdjgDWQHoo8WJI00K5UWn+f6/kvgi429kHzcNTn7cnzvRYeN
 h0Q5N+8baldViEmHjiwZQ1kjYpRt0OSzKR1Vskqe5lhdqiXdT75SvQWZ+xrIMe9czs6qkQ
 UlUHJiZdS63js8iogEK4xwmqxKf1BLI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-Iipg9nH2MN6ybO3byCui0g-1; Wed, 29 Apr 2026 04:48:27 -0400
X-MC-Unique: Iipg9nH2MN6ybO3byCui0g-1
X-Mimecast-MFC-AGG-ID: Iipg9nH2MN6ybO3byCui0g_1777452506
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8aca3b7b536so316910506d6.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777452506; x=1778057306; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xPm3uk4GzUVgYO/3ToxqhNt6kEYKRWKRamKVfR0wUM=;
 b=Ehzg9z0Xmp3jt5HGEBWZaTzW4wj1cgO/mm0zGvybfdGbgv7sJUiHSxmCEFfcU3L0q+
 HWRkVPWtnF3eiksoNUAZ6ifqHLGbF6x8mNaLGi1LORgal+/zgUeGGCAOeSSvGHRwivuZ
 qhbyRQyUaLZJcIi1C8uQQw8AqGzKHK+tRDvHwD7hoRaX3un6DH5H6CiPGJkD+/2A713a
 MqoVGP3/gkBhdmOFO4Xc9nzX+MYQuKdpNy/XLEUj52fTrpD6BCedE1qbdMVVvoN0U/i7
 dbeXKi04NYEzao/CGitcnAp8RFQDzALQI1kuvraT20T3kvDGUwCJ1l/ZO+Ta2OGSQVzz
 /QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777452506; x=1778057306;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3xPm3uk4GzUVgYO/3ToxqhNt6kEYKRWKRamKVfR0wUM=;
 b=o43hxrqa6EKZTAzLef1D9Cj7blv8vdtno9lDzD9jHcYONboKydK0bYhSjmcBboUfx6
 DNMBTVbcfNdRMcxjY+BHy+NzpW+mpAcMQWz0p16J5eFScyXXy4+YbX0cknXv24U0mUYo
 K7IY0rDEwzCmiJJTKJo4/jv3/JqiTmMHSmydg3YyuxMEOgNzkAUeF3KZyT+X6teWUHjS
 IwFkF22j/lDf70THYZVyu/vpDWCRqlrkaKIcj3x9jDjFRSaC6EPJk2iB+q4cTYxcNzvu
 GKn7gPoAHjEz4yJDSyaDFK4WLHqqNuUifgeuO6kjQWoBnqSzJQK0ZVZDuM6+OM6iI/el
 gqUw==
X-Gm-Message-State: AOJu0YxAODBq6u7SbfQhOuvpbZsZlF9OD7Szm6/682Zi/g6qzHmfl+5j
 kbCAktDc0zB/W7wVSVIAHF2v91/UNZTF9679gNz0Li7K1HW7Uyb+WSErL1st5liwIL8LXC8tRV0
 WtNPEt5j1MBekTzBMV8U3+g7fcLSccYabpBYrRgWoNQw58zAbGuS9QaOS
X-Gm-Gg: AeBDievwxKwTfAOZGbcZ65DcKuTE2ZSrLo+gV0TubBKEmkeSDin0Qrpj1K4hiQXqf9G
 VVyHJ5tGFLoQbiWqL2n6hrGPVWdyui+r28WZI4nyt0S22lDE3vYz2JQI+FNWpX3lFDsVzwr/8hU
 7GC/+bO3l9/FU4DP4Gl76uaGGre/v4bPo2NaB41omFQXhfbqmPfZtdxiCC1Y1MZAxZoS7vn/Ojy
 iUsoDQFIqd1iZllqpNR2TUVT7X6suS5rNNZzAnkg5zYKp1cFK8tFC62hE4SZmzbL8bY6gDCUZGh
 ZuFVfk9sdUECpO52jH2etsr9cv6ziPdTZZLvUFzzQKOZ4DmxvfhHcN05MEF7RP0PIVtYtdXl25W
 crIJvUYw70eXN982dKxvvbOo2wtnBePU=
X-Received: by 2002:a05:6214:262e:b0:8ac:800f:10d8 with SMTP id
 6a1803df08f44-8b3edc82e4emr46650876d6.3.1777452506521; 
 Wed, 29 Apr 2026 01:48:26 -0700 (PDT)
X-Received: by 2002:a05:6214:262e:b0:8ac:800f:10d8 with SMTP id
 6a1803df08f44-8b3edc82e4emr46650616d6.3.1777452506051; 
 Wed, 29 Apr 2026 01:48:26 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ef80f7c5sm13039426d6.33.2026.04.29.01.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:48:25 -0700 (PDT)
Date: Wed, 29 Apr 2026 09:48:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/6] qom/object: add object_class_get_list_by_name_prefix
Message-ID: <afHF1nf_FaBAt6mr@redhat.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
 <20260428234519.1812371-5-pierrick.bouvier@oss.qualcomm.com>
 <177745176385.2166241.2869123011864084966.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <177745176385.2166241.2869123011864084966.b4-review@b4>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 29, 2026 at 12:36:03PM +0400, marcandre.lureau@redhat.com wrote:
> On Tue, 28 Apr 2026 16:45:17 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 510885218ba..a6d7b3874a7 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -1033,6 +1033,19 @@ GSList *object_class_get_list(const char *implements_type,
> >  GSList *object_class_get_list_sorted(const char *implements_type,
> >                                bool include_abstract);
> >  
> > +/**
> > + * object_class_get_list:
> 
> Should be "object_class_get_list_by_name_prefix:".
> 
> > + * @name_prefix: Name prefix for type to filter for.
> > + * @include_abstract: Whether to include abstract classes.
> > + *
> > + * To the opposite of object_class_get_list, only matching types are
> 
> Suggest "Unlike object_class_get_list,"
> 
> >
> > diff --git a/qom/object.c b/qom/object.c
> > index f981e270440..14527108a2e 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -1062,6 +1062,30 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
> >      data->fn(k, data->opaque);
> >  }
> >  
> > +static void object_class_foreach_match_name_prefix(gpointer key, gpointer value,
> > +                                                   gpointer opaque)
> > +{
> > +    OCFData *data = opaque;
> > +    TypeImpl *type = value;
> > +    ObjectClass *k;
> > +
> > +    const char *name_prefix = data->implements_type;
> 
> Perhaps the "implements_type" field should be renamed.
> 
> > [ ... skip 11 lines ... ]
> > +    }
> > +
> > +    data->fn(k, data->opaque);
> > +}
> > +
> >  void object_class_foreach(void (*fn)(ObjectClass *klass, void *opaque),
> 
> I wonder if we introduce MODULE_INIT_TARGET_INFO, is this all needed?
> since only TargetInfo types would be registered..

Yeah, i feel like this patch should be redundant if we provide  a
separate initializer for early types to get registered.

Daniel


