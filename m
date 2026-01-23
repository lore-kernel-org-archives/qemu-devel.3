Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53ED8D72369
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 10:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjE6n-0005SD-3n; Fri, 23 Jan 2026 05:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vjE6W-0005EL-Fp
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 05:09:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vjE6T-0004Bo-RC
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 05:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769162959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m1izL9Sy4dp5RFm/KUeVYDDu2oQk147KgcABa8zZ8vE=;
 b=ZZkMuSqlH3T/gj6ZBVSab48JSZd2M64BTCnLGVPQpfgvO8SwjDNvVuQqMGlkK0Sf9lN04G
 Fcy/xOAC+fyJqkpRZdM2lu+ofN0jPHDKXQy4h9bKKoK72Xhw0TDtyJvDNWI7qAcw5R5R0J
 bPJwF0XYggTbazRLdfInR8qrVeMTsMk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-zmTdwAdfMienahvUW3SNVg-1; Fri, 23 Jan 2026 05:09:18 -0500
X-MC-Unique: zmTdwAdfMienahvUW3SNVg-1
X-Mimecast-MFC-AGG-ID: zmTdwAdfMienahvUW3SNVg_1769162957
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4802bb29400so31642195e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 02:09:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769162957; cv=none;
 d=google.com; s=arc-20240605;
 b=EhqmADPebJdjD31UvxOZdOsuVIPn1MX4XxidBn3OkJj+nAIP9QVSEbfKYdkrd2QsLl
 9TYUgSxtxdUrG3qCatRVdlF06u3/lwe9/8s9v0K3qpuXeV/gLr8jAl7wN5i6/8+480Iy
 ull03aqOXSPoBjcJt0v3QJbUyqRJhexRJYANli6xjekiEx/SuIsbT2FCIcbC9CrNCr/P
 ENf3fXy2RGlUqr0AUAwnWNyeCOd2XHMFUMk8T+KZwH51k7q8CfpoozQHxmKiBvN8H9Cy
 lk3bbo9W3gRCL2oPlYyUeEjmyiW0zxcxExSNbKVax6Fj6K3utOM4fV9Ktx+Bl67OuNyP
 tALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m1izL9Sy4dp5RFm/KUeVYDDu2oQk147KgcABa8zZ8vE=;
 fh=DEybb2UXD9PBV5JklRkcMtmveGBUQm650yQ/EG4ap/8=;
 b=RCDkxtJUcV84j0fR3IuMjFnhlyEb4ZHTbhh2+GUdB2jRredL3SrXGLabudpoHLVm4w
 G4/Oz9N5wggAXAOeXN14fbNcg1m80BrrTbRvA78VVfImUPl2eQmqed8MqrdrPVDtjJcH
 K/Q+ArZB+ED5uim9zD/NNoqI8NCRoHHOz6QVFi/uTa9dkQqPge068DtGDzeOSFdIKprq
 EfZBgaw1TpjedWR4chV5azArOU7FrHq53f7rgeOJRZ9ubEjg/qnZVdK4UkTr94BG5KJI
 UgKyjWUak8UIR5tbwKKDKCsu9DtDidPI3k0XH8BT/EwIfA6lv/SgcbP0RG2fNcX/ZwQE
 fB0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769162957; x=1769767757; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m1izL9Sy4dp5RFm/KUeVYDDu2oQk147KgcABa8zZ8vE=;
 b=kCpyYOUl9Z9IQhIvhRuJ85vGVsCaclT2eMJsJikTi/IK/ZC6GHOSY3L3IPMG3cJwe3
 uo0C1WQjse3uZFDf0hJQsbTOiRt/u1/Bh/ORf+IX35XfeTVkTFkzCPMiSM05nrXg2PkE
 RGy7Y3tNBMWZNbINJaFmqQ5EVtpIQeCeUnYBWtg5PhsQ2SYwtqg/q1dzYEMz0tmYMxgd
 fuz8X6so0CtrAO0m8T53X+S3wd3Wqi4Cw1Dl+6rrKxBdhQVLP7u2iYPGGmIKYiUJGFjr
 5zWwxuwfaXJTbb2LGV733ximgdwXTDxDlmRtAiuQ7oVzwdB11VF6FX04N8qc9NQBRO+B
 8mUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769162957; x=1769767757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m1izL9Sy4dp5RFm/KUeVYDDu2oQk147KgcABa8zZ8vE=;
 b=v9vpVJMFwL9GDSOTJLzVBucQTtPP3QASPiD2pjJbjMwWKlZjhKVvdG7GZ5P/XuC6Jj
 19+R9JAUFXMoeddKo/1GL2QPfZi0JyDYm39aLGh7HsFNNdKWr8DCgAnQj15P/O2UFPVC
 v5X63FThCvkv9K5UNpjczNqWlwkk4vA/5GJCpMdUZZR72OCuddMBQz3lm/kk6xsmCh/C
 uPDBmYkyxaZpPkXIHitMAvc2rYl7I9eQwcPmXHLpFYdqzsbdCfO3XhxPCa+shsdCW6Hq
 ooNyQhigdU/xDY02awHpa/O9zOohoewBVKip2JAYuXfeouocm+pBtT03W1kphjcj0CY9
 7Crw==
X-Gm-Message-State: AOJu0Yz14rsir2+nwNCaGdGn2sxggB0gvpk8Wf+bCGtqJK6X46K6T4vq
 Lhm4suIr7zhu7w8XL6Y+V2tOzEO2Xk6yd9VCdYJDlpcDWoHbnaJlcKIBaNtae8c69aW7zlWm8lp
 t3rhC7ftqScCXo8HuDEtF1YYxUnm01rh/Iu1RUuZWallW7SFaQZmZT98ZIxT1mMLAZvg/HDiF2g
 S3HXsD5FnLJJe7GAehYjuRGaiBPREQ/LQ=
X-Gm-Gg: AZuq6aIlKAA0TUMxdY0XVPr+ytyQ92Oj+O6pB+rIdx+WxUhFuq5kpHJThN4NYRK4ah+
 A69ypSMb4V3XE8zcdmUtkCaPAxjbWtnRRYvgVicHs9/jQXV2HBFFIpcy8vyyPHwNaMm9aTPvxwk
 KiiR4Ra8a359ddva+6Wg0WujWMgm1REkK31NsNBUzH7+g9niV3+3Jl2irPNoGjCgKeMGQoixBkv
 +RGNJyBeyPRMym30br6Rzlbv0H2Ulw3n1DZaqReD56oYx1umMtw6JjY
X-Received: by 2002:a05:600c:c105:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-4804c9becc1mr31001815e9.22.1769162956829; 
 Fri, 23 Jan 2026 02:09:16 -0800 (PST)
X-Received: by 2002:a05:600c:c105:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-4804c9becc1mr31001445e9.22.1769162956339; Fri, 23 Jan 2026
 02:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20260122232456.12722-1-farosas@suse.de>
In-Reply-To: <20260122232456.12722-1-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 23 Jan 2026 15:38:59 +0530
X-Gm-Features: AZwV_QjJSPNhXpOLgaIz3Xk9DnzMr_Kg5ixvM_kvrl8berbueqogTwzcJqxGe4Q
Message-ID: <CAE8KmOyAYnB8a-AsZvjCFGrX+xwbCjV3Wv2ybVLoBQu7RofOqA@mail.gmail.com>
Subject: Re: [PATCH] migration/options: Fix leaks in StrOrNull accessors
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 23 Jan 2026 at 04:56, Fabiano Rosas <farosas@suse.de> wrote:
> Fix a couple of leaks detected by Coverity. Both are currently
> harmless because the visitor in the setter can never fail and the
> whole of the getter is unused, it's only purpose at the moment is to

* unused, it's -> unused. Its

> provide a complete implementation of the StrOrNull property.
>
> Fixes: CID 1643919
> Fixes: CID 1643920
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2280325023
> ---
>  migration/options.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/migration/options.c b/migration/options.c
> index 9a5a39c886..9dc44a3736 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -225,6 +225,7 @@ static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
>          str_or_null = g_new0(StrOrNull, 1);
>          str_or_null->type = QTYPE_QSTRING;
>          str_or_null->u.s = g_strdup("");
> +        *ptr = str_or_null;
>      } else {
>          /* the setter doesn't allow QNULL */
>          assert(str_or_null->type != QTYPE_QNULL);
> @@ -245,6 +246,7 @@ static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
>       */
>      str_or_null->type = QTYPE_QSTRING;

* Do we need to add:  str_or_null->u.s = g_strdup("");  here?

>      if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {
> +        qapi_free_StrOrNull(str_or_null);
>          return;
>      }
>
> --

* visit_type_str() failure is handled in set_StrOrNull, but not in
get_StrOrNull? Do we need to add qapi_free_StrOrNull(str_or_null) in
get_StrOrNull()?

* Otherwise it looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


