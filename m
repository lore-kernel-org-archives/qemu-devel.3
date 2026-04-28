Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09368FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdBr-0007ap-0B; Tue, 28 Apr 2026 03:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wHdBp-0007aX-Jg
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wHdBn-00080m-5U
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777362541;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KOgPM3wPTrp1s54E+EiUxRUBtD0eiw0KdLxGC4zPeco=;
 b=NXZajJrnB8Xy9TfgBvxsgN61FVp+tgFBl9nNlCTkIa+00nEVCebW/1ZONWGNfOyu72KYpf
 y9fPuCBtt9m0Rpp/Cjp7dqF5EE9g3KyOPFaFxR7n4GcEQ9KjqYZLRI8rsYtSLVYmlBnvwO
 ORdoKphaLZ+e+rfYb3z+zVyRxUAvX+8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-6Zdvi7ohPPuuUWrsTKHbKQ-1; Tue, 28 Apr 2026 03:48:58 -0400
X-MC-Unique: 6Zdvi7ohPPuuUWrsTKHbKQ-1
X-Mimecast-MFC-AGG-ID: 6Zdvi7ohPPuuUWrsTKHbKQ_1777362538
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8e8950b3ee1so2940518785a.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 00:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777362538; x=1777967338; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KOgPM3wPTrp1s54E+EiUxRUBtD0eiw0KdLxGC4zPeco=;
 b=C5YGgJcm13l8UjF0IXLyiMMwtwV/Ua7dsc3yj/nsmc3isO7Ma2rsyi7RWbujx9IU5d
 i4JrN9F3idNUNosTCWbK/v3mLTq7XH465vgwGJIFZJpZf3M50U7fM27nZ+StTtB3iagO
 Po5zjrZA/w77LGXgPiP6SKgeJ5mEcSbaN6jqgE5uLVv6J8kak26MbNG4tJSaNSLCAI74
 OGYN+9GPS3SDvwHRbC8thBR/6U1jbQZS2vprDfRJ/0kJkqUQwVaiTQ6CumvnJHzRu+aG
 BkBiUxFEaV1KI3XUKCGqwMpfC+xFNf17/5hbm7hDFpdhrhfGXjwyR4WzaUGXcQqm+wRW
 SUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777362538; x=1777967338;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOgPM3wPTrp1s54E+EiUxRUBtD0eiw0KdLxGC4zPeco=;
 b=mxiIJQ4jivjZxZxf0srLrGsWMt8uOfx083JJgQMdN1PfRfyEwOJsCJ3REAPnp9Axis
 V/qGTkv0yBHTb7e6+Wnk2q2bPvbC5ztia5orRMHGYLT2oE73q9Ib1UOz3PHneMOqJ0SY
 CR/Y4Wh0I7JuhhAb/UcRnAQw1C+PJhtweV5gsEb3kyijKj0vw625hgo9DMkqOp5nJXr6
 9zhGTUpLU1PtTGQ/TSwmqISTrdD/erNSu+7rPO9F2KpDl7Ggm2C9EJyVpCOo3FqwOW7o
 KqiDWUXXnTo35d7J3RyVYwxDJwMtatHxLSiSxXHcrk8HSgWBWdpB7gwUC/fJFURjL78P
 3fqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uvebbBqwzHeohLDT0Lc3UHs6xn56QkoueTrP46NOxZvl6S5TMxp62GlJMP/XH0Rb0shwd1PQ7BkTV@nongnu.org
X-Gm-Message-State: AOJu0YzqcSLU+8iWVtqPNXjt3E2a5H5cTekGu0MBsJw5TTfGNDWFtpZv
 CdsUCBK/Vp89cCcGXfYtOuaKF+Z/YV/YB3M/B/TlDZbTW2YHm+oHkwoW6FY4z91QLXSyQiT33G1
 UesBDQWreUReWFTLKfWtlAFRd5o6KJKHQBtCTN8IMQiNrwgewvZ/3FGJS
X-Gm-Gg: AeBDietSI3bv5i/QUuBvLLnjt8CWOV87GRzc4jpN85a/uksCQ+oJZR8T2ig93N9fAjY
 RuM+VPXJCQhxmie7INq1u3TVQI59rSn1vDUyQ2smXoAYQhn8TTaksD9l5NGiJeWveMjs9Wck23o
 Nl23g2q9X1rd4NwPOJLrrYXHH1TZrEddJ20nVnF2Dayhq45m8j4MFfHWwNwrUSJO0yIPLPod2ZF
 Xide1gUXlY87NQqIAIxgNHKMbwVaatubEiIoEN27BlCcdhDqh3KNYBqO6iQDFNtmAh+1aTuqEIg
 XLWoPosZ5FayCcRKv3Y06r5Jw3HnC7GF5HqacCGhuR0vFJI5t3tQ0uM3E7rpUC1/dGi4eIUbqVH
 xfVLWFF9xRMpD52zM7ausLl5cUvCnPyo=
X-Received: by 2002:a05:620a:404d:b0:8b6:1877:3689 with SMTP id
 af79cd13be357-8f7d8f0e7e3mr258414185a.35.1777362537552; 
 Tue, 28 Apr 2026 00:48:57 -0700 (PDT)
X-Received: by 2002:a05:620a:404d:b0:8b6:1877:3689 with SMTP id
 af79cd13be357-8f7d8f0e7e3mr258412685a.35.1777362537100; 
 Tue, 28 Apr 2026 00:48:57 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f7c49c4953sm125560485a.3.2026.04.28.00.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:48:56 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:48:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 2/2] ui/gtk: Turn clipboard flag into runtime option
Message-ID: <afBmZcEGoC7C5md5@redhat.com>
References: <20260427-gtk-clipboard-v5-0-6968feb31a5d@gmail.com>
 <20260427-gtk-clipboard-v5-2-6968feb31a5d@gmail.com>
 <87340f5yoy.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87340f5yoy.fsf@pond.sub.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 28, 2026 at 09:30:37AM +0200, Markus Armbruster wrote:
> Jindřich Makovička <makovick@gmail.com> writes:
> 
> > - Compile the GTK clipboard support unconditionally
> >
> > - Introduce GTK clipboard option, defaulting to off
> 
> Should the patch be split?
> 
> > Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
> 
> [...]
> 
> > diff --git a/qapi/ui.json b/qapi/ui.json
> > index e3da77632a..b2c42a7f57 100644
> > --- a/qapi/ui.json
> > +++ b/qapi/ui.json
> > @@ -1319,6 +1319,9 @@
> >  #
> >  # GTK display options.
> >  #
> > +# @clipboard: Enable host-guest clipboard sharing.  Defaults to "off".
> > +#     (Since 11.1)
> > +#
> 
> Educate ignorant me: what does it mean to share the clipboard?

Conceptually the intent is to create a single logical clipboard
spanning the host & guest. IOW, if the guest copies data into
its clipboard that is made available to the host clipboard, and
vica-verca.


