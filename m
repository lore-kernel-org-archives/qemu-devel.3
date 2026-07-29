Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C987C53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 17:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp8GY-0005DV-6C; Wed, 29 Jul 2026 13:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp8GW-0005DM-Ow
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 13:40:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp8GU-0005P7-QC
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 13:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785346821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8ty+y/wFQYmnzv5XMOibILjBW8+1jAsgcCUFAaFz2U=;
 b=NlwALY46rm+0EHIN73hk5VwhgtIBxi9O5KdbQXNJfqz0LjypYoezgmgzbyL7aG5R99UE1e
 oZGOFo2pOoF3mO/QTm0Sie4EPgFCbnA0vS3y6A+C1LaCN2wHWBDePOzEDd+L2hSXefBfOO
 JLCc3iJYSFbgzodQoPfsvzvUO+s3z2w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-3mGhbMOHM5e5K9y4T5azzQ-1; Wed, 29 Jul 2026 13:40:19 -0400
X-MC-Unique: 3mGhbMOHM5e5K9y4T5azzQ-1
X-Mimecast-MFC-AGG-ID: 3mGhbMOHM5e5K9y4T5azzQ_1785346819
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so20790091cf.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785346819; x=1785951619; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y8ty+y/wFQYmnzv5XMOibILjBW8+1jAsgcCUFAaFz2U=;
 b=DSqkS7oXaTQNhv28qPyB4yjvyrBdVIJjce0+zcqNvtghin2bFpkb5Y7Ilya2wpHRHv
 OEdESGTBo9W2mupW0gKizgXINBOrw90dodd+wd9YvCNLCOaxh6e4yb0/+vhr7F06m1ke
 yQ9iwJ65Sdu66ND7PYeMyAFAWxAONyc38tkLtLfvHxCTqG07O3RfcxU39/+PNpXMrIey
 gRi0E2ry8sNMz0YipoOGqXWkBCmyxEbSxIZ1Dq9j8+XLc5YlyM1tP2BIxTrB8OmeJ9EJ
 1oBZY3+sH7PUjvdMD7vJgze+gx55Hyqr5JUdM+mWAPnCKAAn1FqfIQn8qyIRAaQJzuXb
 imTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785346819; x=1785951619;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y8ty+y/wFQYmnzv5XMOibILjBW8+1jAsgcCUFAaFz2U=;
 b=Q4lSHm+/rUtNWDu/Kmcgstmi3m+F8h4Bw1+/ntHoD2D0D8h38mXK2CBlwqcvAONfp4
 cyviXt6DcOH8cB4zeoWnk+9wEcSmHM/3ANeBjk9eNYYAvAwnA4PK5RTuC33g+HU/1V4x
 tYtW5lIi775tg1hb+erQ9RkLsh4w9qiZXP/0SRJwjPXIct+HiGxIScVB4T9pGQx56Drv
 Lc3tXcsZEHpozrPCYxRRNCQUX3biQKmYYo215PFDE9htNP2KcWaLPTj61CXzM9727XvA
 DUlcp7pTLEAbGeSDB4OZszOpEW1/3XqN2By3s6Yyht9UKDyYPS7W+WjfBHzrmptTOTZt
 thOA==
X-Gm-Message-State: AOJu0YxSmxepu+3aaYxlZs+6SFltVm9OYHbbo3HaS0uTZZud718qbZqr
 GR/FZn66BGV/AXSSAuAvuLxjv3I5JRNpuK/bG6OhmVcTJjz9hlEqIe71PDYdpTHshccnIHtfYla
 pawF2LsVmlR3yie7Zlk0q49/KyRtHACLxB0ovcAXcFhNUwWCWI/UQaXgp
X-Gm-Gg: AR+sD10gZbXNdKMNCAA8Fj3E7xow1XWN1MlW+r4Wb6vRIIt+5V+v32lA17BZf/XrJbe
 wyMVTgEsSjSP+by0y3MIvSS1HB//UzTwh4ueh0wW8037zBmPmEaGR+1MYUAdnrj+Tce+x4+OFVg
 f7BzPjcXi+HJSt3uoNE+xDL0bU8wVS83sNRfdHm4y84na2k2ATTY0LCSuRyJfDC5wvxg8Oo+IAg
 5HVTqNbF4KSXEnVSXcpmUIYYMWoisKrhAF47PK4IEoLtpdMhTmtbxhExxXvJWNe0IMz5X730CZW
 FS1Spdi9y6CAwcaTSNKai1O4LTJa6LdaSW+DfD3fQByLlZ0eRMtNpDVfbuQI9Cw9OFxY
X-Received: by 2002:a05:622a:1191:b0:51c:fc4:a144 with SMTP id
 d75a77b69052e-529d70557e0mr75702091cf.4.1785346818694; 
 Wed, 29 Jul 2026 10:40:18 -0700 (PDT)
X-Received: by 2002:a05:622a:1191:b0:51c:fc4:a144 with SMTP id
 d75a77b69052e-529d70557e0mr75701531cf.4.1785346818044; 
 Wed, 29 Jul 2026 10:40:18 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e30fc51fsm23518071cf.30.2026.07.29.10.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:40:17 -0700 (PDT)
Date: Wed, 29 Jul 2026 13:40:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
Message-ID: <amo69qbbLChFBaUY@x1.local>
References: <20260728153942.1891677-1-peterx@redhat.com>
 <87jyqeomqz.fsf@suse.de> <amoHbVsgzkYclCt2@x1.local>
 <878q6toopr.fsf@suse.de> <amof2Vbn_nTHR5H9@x1.local>
 <875x1xojtk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875x1xojtk.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Wed, Jul 29, 2026 at 01:13:27PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Jul 29, 2026 at 11:27:44AM -0300, Fabiano Rosas wrote:
> >> Hm, but isn't it better to have a global cap anyway? So we don't need
> >> every device code to change with similar checks.
> >> 
> >> > If we go this route, I'd rather merge Michael's version to support u64,
> >> > even if we don't need a u64 size.  But I really don't want to introduce yet
> >> > another VMS flag just for this... we'll have no real use if we have noticed
> >> > this problem when the vhost inflight patch was reviewed.  It will be a
> >> > uint32_t or int32_t already.  I just can't come up with some users need
> >> > size >2G.
> >> >
> >> 
> >> I agree with making all u64. I think we can actually remove all the
> >> extra VMS_VARRAY_* and VBUFFER_* flags and instead doa single type-check
> >> of "int <= 64bit". Give me a couple of hours and I will post an RFC.
> >
> > I confess I don't yet get what is the global cap you mentioned.. but sure,
> > I'll wait and read the RFC first.
> 
> I was thinking the vmstate code could define a limit to the size (of
> anything) and always enforce it. The device code can then use some
> custom macros (not yet existent) to limit even further.

Ah I see.

With 32bit limit (let's assume we don't have that further "it's int32_t"
problem..), it's already throttled to 32bit max.  I added it into vhost
code only because in reality it was a 64bit internally.  None of the rest
users should need it since they should be sticking with 32bit fields.

-- 
Peter Xu


