Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7707D0E6F5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 15:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNvGT-0000Ze-S9; Tue, 25 Nov 2025 10:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNvGI-0000UF-6e
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:47:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNvGF-0000gK-Ed
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764085641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjbv0NVzIdfY1aNuAZLoLj7kPZbvq1QJ9TntdlAvkxg=;
 b=LuO3AxwjcikWa8EOkfIN+xrgQzV206I7hsJGRbRE1I1FpTvIwLAXEg2fKQYzlZ5EimpfgH
 xds4ylNntDHpirYQfJBewNK/H7xry+ADNiqimwyxvx+pIjb8+CS7PbG85e0oQS7CRtYf15
 zJhNYzcO7TnGcfC9XX9ZFeWub1V8FtE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-IOaMsq18N9q0qFYCSp9aZw-1; Tue, 25 Nov 2025 10:47:19 -0500
X-MC-Unique: IOaMsq18N9q0qFYCSp9aZw-1
X-Mimecast-MFC-AGG-ID: IOaMsq18N9q0qFYCSp9aZw_1764085639
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ee416413a8so53902581cf.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 07:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764085639; x=1764690439; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kjbv0NVzIdfY1aNuAZLoLj7kPZbvq1QJ9TntdlAvkxg=;
 b=YfEl1P58MFsuKHXzejYiOnXVBp0zdg1s+GPidGMZpMdFsNmxlzcc/l+hREjh7km0Lv
 Tz5+brVLhdrEaY3gfAnY5+5HACjeJ2dfN4EyeKgcH1RxlTGsbdsvKVzHn5eMDXoIfCPd
 0cdO+G1r+sTzdvsacT798YMRjcgsANSBaxGcJpiZH5KslFiu1M8r80bCAsdYfnSaDg8K
 Oe3TLJ0F2W5MelySZtt23LQh0BOsQtnaDKrw53x4MlTh6OcfMHTM1VgoWwpnO+NaKwMj
 kfZbQcfJX56T50C8jVqyjR+FzREFiWPCsTKNvBdW3nZz7Fm5gJWtwMPF3PrWY0SwjKWg
 CfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764085639; x=1764690439;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kjbv0NVzIdfY1aNuAZLoLj7kPZbvq1QJ9TntdlAvkxg=;
 b=b1q+ydExAANMP98WuSvJwfhIvjgYL1EA3RuaGnVzX6vBg70l9LG1XgxP1xuEFORnPw
 K7qDbRxkpyg85+6SU6Yan6YJ8ciY+iB5ZUMeNYDrs/8phP8qKQ1cYLWoQHNjqI+duuLb
 wVydMSG63OZc9jFUvsXnNBG41ip5UG/IGfTz2xPtw6j7R7faLTTC6qnanxn8wEPzdVv4
 AejutE0G3f5UUm7Y2D/YttbHK5C+J/l0zNhm30HxRAHB0mEp6CKC6YDEhK+t1qmUP1f5
 c4w7INEl1+J23cQhgIwt0k9xKqsEGHAE/V6S+PeJLPM78CtBwMugMOFWNiAw1WNGotxw
 IG8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxKAhSV+OxUB2MdL4OG6Gcv9DLSeUWicZAdbEpfwTr+xEOAwX499OlqTNU2P4DcRGBOd37v8SIAPG8@nongnu.org
X-Gm-Message-State: AOJu0YzOiS+ekfCnaGS/qEH1RBieUAuO2p8ntKgm4aprvEnqqLzdVtkO
 Fuk9bcbtNvCYfeoMNFvlQwyIsn59VWw0ihikoiNOONZmHBoJTU/SNv/ncdLA1L0kdYBiXeWDz9X
 GvftXHGRpQNQCagHIPs4x0GxtVadeO255lvOAAs/hqzvcwFn8yONsCtmV
X-Gm-Gg: ASbGncuqLo2CSndkHsPELi0EziTKTgZfIPoLwfoqP/Glt6r6GpU1VFnb5qCbfDKVTx3
 5W7SKJWe8hmA5c6U/9bON9LcoYvvxmSz/QYJ3mfBanT+C/uiwehhUr2VRTspZr5TA5e+5AIU/Ma
 5mfwO8rQMI4U/fiZ27W5OqkhP++cdu360EGheC7Y85l33k9UOVwZ80HupjpdMCUstFB1ZxOFb6b
 0sIzPKU4zZPY2XJzHryhvrZO1LaVwO5BhrrbbYVVjG3QKMhrLqBoZJtv6bLHKaIPt2P72d4YBJ+
 jpccvbRIKorQHla+rhgrahShdRkk00zso3mr+6P3/R5DPlzYHpvKqfNXaO1ruQiBFJL3gYMm2l2
 7mJ0=
X-Received: by 2002:ac8:7c53:0:b0:4e8:a850:e7db with SMTP id
 d75a77b69052e-4efbdad7f96mr46270191cf.71.1764085638649; 
 Tue, 25 Nov 2025 07:47:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqNMDRg851SAlhx7A+zAlVRju9eh/d0GZ7ZRiEC0ty4aq3ofVDRT//COKka2xQj++tRR0gjA==
X-Received: by 2002:ac8:7c53:0:b0:4e8:a850:e7db with SMTP id
 d75a77b69052e-4efbdad7f96mr46269661cf.71.1764085638125; 
 Tue, 25 Nov 2025 07:47:18 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295e4b96sm1201206185a.45.2025.11.25.07.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:47:17 -0800 (PST)
Date: Tue, 25 Nov 2025 10:47:16 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org, farosas@suse.de, peter.maydell@linaro.org
Subject: Re: [PATCH] migration: Fix double-free on error path
Message-ID: <aSXPhOV86fyaY53_@x1.local>
References: <20251125070554.2256181-1-armbru@redhat.com>
 <CAJ+F1CJ918Y9e=yTHFSqZo0QGmmD3aT6Zq+zxQ81t-gjKkUJPw@mail.gmail.com>
 <875xayxo6t.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xayxo6t.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 25, 2025 at 01:59:54PM +0100, Markus Armbruster wrote:
> Marc-André Lureau <marcandre.lureau@gmail.com> writes:
> 
> > Hi
> >
> > On Tue, Nov 25, 2025 at 11:06 AM Markus Armbruster <armbru@redhat.com> wrote:
> >>
> >> Fixes: ffaa1b50a879 (migration: Use warn_reportf_err() where appropriate)
> >> Resolves: Coverity CID 1643463
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> >
> >> ---
> >>  migration/multifd.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/migration/multifd.c b/migration/multifd.c
> >> index 6210454838..3203dc98e1 100644
> >> --- a/migration/multifd.c
> >> +++ b/migration/multifd.c
> >> @@ -450,7 +450,7 @@ static void multifd_send_set_error(Error *err)
> >>   */
> >>  static void migration_ioc_shutdown_gracefully(QIOChannel *ioc)
> >>  {
> >> -    g_autoptr(Error) local_err = NULL;
> >> +    Error *local_err = NULL;
> >>
> >>      if (!migration_has_failed(migrate_get_current()) &&
> >>          object_dynamic_cast((Object *)ioc, TYPE_QIO_CHANNEL_TLS)) {
> >> --
> >> 2.49.0
> >>
> >
> > Maybe warn_reportf_err() should take a Error **err instead, and clear
> > it (and accept NULL values)
> 
> Our deallocating functions don't work that way.
> 
> Having them take a pointer by reference and clear it gets rid of *one*
> dangling reference.  There may be more.

True.  However I need to confess I like Marc-André's proposal.. Normally we
only have one Error object, or >1 objects.

The only thing I'm not sure is such design doesn't match with the error API
(e.g. current form matches the more famous error_report_err(), and likely
others that I'm not familiar).  So at least this will need some more
thoughts before all the code churns.

Thanks,

> 
> Coverity is fairly good at finding the kind of use after free this could
> avoid.
> 
> Error ** parameters are almost always for returning errors.  Not having
> to wonder what such a parameter is for makes code easier to read.

-- 
Peter Xu


