Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DBDD10F58
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 16:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOIES-0008FU-Sk; Wed, 26 Nov 2025 11:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vOIER-0008FD-2Q
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 11:19:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vOIEO-0002ng-Jw
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 11:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764173938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXuF7kMAHT5UxTglPhSovU0V/p1FugbL6sFif7j33Gg=;
 b=SHZg8n3hMsLmiULEE/inheN41XXpaseOSGuXRX8OzEHQzFFPaxZtWDU7uUz5+bTl5u/ATs
 gwZfcordtdVxls1zOWeOTlQISLzK9mBYMgxB9uUCZ2CbB5PVgXE9t99SBlKDU1d537CtnX
 p5F776UdG7mqeohYRqq+gzaJYl9D5qY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-R7LP8yvUM5277A8Jhdqu5Q-1; Wed, 26 Nov 2025 11:18:56 -0500
X-MC-Unique: R7LP8yvUM5277A8Jhdqu5Q-1
X-Mimecast-MFC-AGG-ID: R7LP8yvUM5277A8Jhdqu5Q_1764173936
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b2f0be2cf0so2280637085a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 08:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764173936; x=1764778736; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iXuF7kMAHT5UxTglPhSovU0V/p1FugbL6sFif7j33Gg=;
 b=dC+Zj+qIIkKCzOKwBcHs8PzM4Mrxf5hIVhW8Qhjdup/eeOmDVxBplgMnnxmiyAeUkY
 dyzs79EembIVukbnJnrXwxr+MG5ZmWxiiJ8fmm54LJSJ5i2fIYtILpqV2X68I/CgUC5s
 sG1et3lEqVux/3Brs9e75jpYKaa1TydOeVnLHLu8DcHjMnwbUtUW686Hvq7gvo/ZCtse
 kR0Y1uUVE4thwR0igzliQ6pg4juRSBCnxhG8/OWi7tpIiOHntBwwXvtm5jsrs1IZuHyV
 9CX0cxJ/rXpdtgsUXzN/EfwihxQ4+EFcgkriNNTrkDUlAwjBhiuKxI+2sirksWnV5Q0X
 3TEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764173936; x=1764778736;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iXuF7kMAHT5UxTglPhSovU0V/p1FugbL6sFif7j33Gg=;
 b=RPqBv+udpOoR3tRyGxzyxsaBOEVnmrXsfDwz+t1ERKX1t9DVbW+IDyfoka817El36g
 TBWLLBNLfbtlaglSngkcFgO6AKrEad+3DUrfevE0TwBT1iif7ME7/KxlD5WxxnDVwUZN
 Zoo/M6fpiQIStJYUiV920TxEy7WraXjsH5KXYMSspaMNL6/4XBTQ+pHgXqhJky1I4sap
 7RdBVvYBY0e7N0IznAEZC2hGuT9k6cXjrhcmY2uL2QkT6TDPJsUySjd7w7UXT02FXEHb
 fvtsZTeN52Se5Jnh5G/eo0GXzuzRJoPv45OnlrhRsnNnlhTTqKvJQ+LOi6FxhH8uPSfc
 Rm0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPylVN2CqiCQkQX8UttXsqlyHB3pSaDaR1BnyWr7b6XqL7zGYaZmCAO1MsaS/ylU0f39O/0iO+qOIs@nongnu.org
X-Gm-Message-State: AOJu0YzOhyx50l+BcoUR7Kpl3r0AgoXx9GWi5g5EJY1hd/TUFGauG9XI
 pZPKILy182EZMYvYyrpa12/cD8GzsHAsLtA4vSkTasgi2CPOn0VZ4IRkZpv7qsP4gaIUlcd7kA2
 4PfMDwsdyAS/u53ik3kbrq+pmo2/aPc/DlZ6KvjeEL4sNt8TrV4IJ58iM
X-Gm-Gg: ASbGnctP5EW6JUvDNq0xGC2efzHlaYfwAeOpvP99M5xWcOclFaU3InpaMx4ycdP+hEv
 tAJNmEHt4CDE/tIqTXEBBtpnNTWYajTb7K7JkbmDKYptSUheSmvrzb+WdbXskbp/VXV1ZfyAtcB
 EySI+dfW6xGLRagz6xLS0IFvAsrxRaF/FzxLVBb8qBDpK82FnvF6qSm9HR8dzjvblwjALOVELBf
 wzcU2tJLj0xg4XfmHCeEEnGfVDOcDAkc3d/DcxZp+lVi6ZDSzZxkR9PK4roIi9XJ0bRS84/MdsL
 +E2cVChQUjkgWzRWEUC0uUCXtQVc8TSqAi7ccPxx+L8UZ1FIt6p66Qnq+PvL00pvY+l7J9cyUA7
 mCSU=
X-Received: by 2002:a05:620a:46a0:b0:8b2:7165:544f with SMTP id
 af79cd13be357-8b33d1fd878mr2651453385a.25.1764173936075; 
 Wed, 26 Nov 2025 08:18:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQLzezK6cnPgwqe3GsQehgIVd0sTHHe8qTopw+80DN1CAhsVgib8D0EwBm+FRaf+MxWA2XRw==
X-Received: by 2002:a05:620a:46a0:b0:8b2:7165:544f with SMTP id
 af79cd13be357-8b33d1fd878mr2651448085a.25.1764173935572; 
 Wed, 26 Nov 2025 08:18:55 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295e8338sm1423399685a.46.2025.11.26.08.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 08:18:55 -0800 (PST)
Date: Wed, 26 Nov 2025 11:18:52 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 jmarcin@redhat.com, marcandre.lureau@redhat.com, farosas@suse.de,
 berrange@redhat.com, vsementsov@yandex-team.ru,
 mail@maciej.szmigiero.name, peter.maydell@linaro.org
Subject: Re: [PATCH 2.5/6] error: Explain why we don't g_autoptr(Error)
Message-ID: <aScobLHb0FQ6o_Gj@x1.local>
References: <20251125204648.857018-3-peterx@redhat.com>
 <20251126143427.2470598-1-armbru@redhat.com>
 <620bdcd0-a7e0-4b23-95c9-9752156a55e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <620bdcd0-a7e0-4b23-95c9-9752156a55e1@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 26, 2025 at 04:14:55PM +0100, Cédric Le Goater wrote:
> On 11/26/25 15:34, Markus Armbruster wrote:
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >   include/qapi/error.h | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> > 
> > diff --git a/include/qapi/error.h b/include/qapi/error.h
> > index f3ce4a4a2d..fc018b4c59 100644
> > --- a/include/qapi/error.h
> > +++ b/include/qapi/error.h
> > @@ -437,6 +437,23 @@ Error *error_copy(const Error *err);
> >    */
> >   void error_free(Error *err);
> > +/*
> > + * Note: we intentionally do not enable g_autoptr(Error) with
> > + * G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(Error, error_free).
> > + *
> > + * Functions that report or propagate an error take ownership of the
> > + * Error object.  Explicit error_free() is needed when you handle an
> > + * error in some other way.  This is rare.
> > + *
> > + * g_autoptr(Error) would call error_free() automatically on return.
> > + * To avoid a double-free, we'd have to manually clear the pointer
> > + * every time we propagate or report.
> > + *
> > + * Thus, g_autoptr(Error) would make the rare case easier to get right
> > + * (less prone to leaks), and the common case easier to get wrong
> > + * (more prone to double-free).

How about we further poison the auto free altogether?

IIUC this should work:

+extern void
+__attribute__((error("Error should not be used with g_autoptr")))
+error_free_poisoned(Error *err);
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(Error, error_free_poisoned)

> > + */
> > +
> >   /*
> >    * Convenience function to assert that *@errp is set, then silently free it.
> >    */
> 
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks,
> 
> C.
> 
> 

-- 
Peter Xu


