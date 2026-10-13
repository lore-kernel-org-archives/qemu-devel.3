Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A1ECC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiDq-0004m8-Vo; Tue, 13 Oct 2026 15:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xGiDo-0004lx-S4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xGiDn-0000AX-HA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791919894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=54cI+TbebtbYzP9tOpi+g3qgcHvLrs3s3ZIHYn5ThLI=;
 b=jPL9kmGgs8MWDBpntJYIQna5RSIE8gTIz8yg+SApwob8OKoR9mbvK85xDRULENjxKhcxGf
 hEW+aIjEzbETIrEwrJHduzEAnilRbFsQMDq1LiijTJ9QXtUZqgwY7im1P0h+cOSSxeDMUU
 x+FBtGmzn5Pw34LLi5G9J4T2peDJSgA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-E6bED_1wPPKiQubzI6H7Qw-1; Tue, 13 Oct 2026 19:31:33 +0000
X-MC-Unique: E6bED_1wPPKiQubzI6H7Qw-1
X-Mimecast-MFC-AGG-ID: E6bED_1wPPKiQubzI6H7Qw_1791919892
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-917bab67568so103660106d6.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 12:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791919892; x=1792524692; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=54cI+TbebtbYzP9tOpi+g3qgcHvLrs3s3ZIHYn5ThLI=;
 b=ZWvKNd0yAgufc0OJOoo4YrlwcWdJwjTPUtJ2iskJwx7ZcylxNwsPSVyxnP/dR+HsRR
 uj07v9zlMJ4BKyni0/I7brHJOyEZ0u9CNt0xWufEG/akwDFl4bXcuNRMrHByf/QYFo5W
 MxjWM5MEDoMlu2thk3lUp5qoJ+BAzdM2xihVz25pudq1HObFu1GMNHv4xNA6H455RASl
 N/qbV2wc8H2+i7KMALXygFUcd1p8QkSkDrww7fGI7DqEAKcirN+iNeDkxJo4edYoE2vA
 VkcN6NAD1ghHQfFM1V4PWaSPwISArLaXxEU7WgLA6cLpK7azxqzz02FLLGulGggoLEgH
 yMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791919892; x=1792524692;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=54cI+TbebtbYzP9tOpi+g3qgcHvLrs3s3ZIHYn5ThLI=;
 b=qDfLmCqCVaLNr8/DgevTk9l8dT774YjTixo8kQyn6nH1D/n861S27UtJ3ENarQtnR7
 Zj9Yg3m1dvopo8afxH5x6MRnpBD9dv2POpsEA7sNzoe2LiwCLfjvnXUM5zdiL5JSnwNJ
 YL89oLfT3MmWRRLORRMF6u8l6kDRMkWNu3Z+FBRGZXBX3Smb7e9Tv8arFCSGkEGYT6QX
 mp85dkJ0GeqsXEbvtV5WlDr/0KkmyoenlElPAqqLsA0eNDVx418QauaJATi0ogZmKCO9
 HA/nf3aR0ks1DxSWLh+uheFJ0wS+FMdx/oQNe/ERtrHRkL44PHsL3FdsdxZQ6jzraBJ7
 yPNA==
X-Gm-Message-State: AFq9FYJLqMkjBdWPsPdoIq3/qmtGuII87s7rkSwc9A2s84rS5AIW1jzC
 u0K4+owbpcSV8Ax5pJyihEYJ7yX0biPHxfLTOdOmg+QMtlz+A/67pUJ/wOx93sFqMYzQmoDlwv5
 0Jb4p/cganBsTWEbDhl4Owev/e0ktcZO/SQfMdnuIGbTaRS1TXhok160N
X-Gm-Gg: AYBFou0Wud9oA8QLbhrSxIb8IN+KwD9yVxXcoS27DJGmqsmFOz7744VzIHqTBPLO6OM
 7UmCSE+yZZk7dbAie73Jr3Xi3VBEuSFcprDwGjSVsV+GKoqQwJhqAh6nchbnUVghid+nWdc6IEl
 wTnp3uSgF93pkjO10aGqjpsy+XNhnB65+GKC4MT0PrZxPqGKQIq5NMDNGQYBaJtb4ZrMCbTmxiD
 /12DbgaycL9Cr3KU8ulVtmJqUR5jzWfT3sxSrTVxksr9+BHMOO+g3Z2VMLWD0PSHtUqGcMTJjBK
 iHbD6Z5HyOm6OQg6MD827X95yvy44ddOBKtp9bDxKCKsmKRQ+VpUfZtCb8r8K3HwB6d/n5A=
X-Received: by 2002:a05:6214:194b:b0:919:85a3:313e with SMTP id
 6a1803df08f44-91b554c3f01mr237877336d6.17.1791919892379; 
 Tue, 13 Oct 2026 12:31:32 -0700 (PDT)
X-Received: by 2002:a05:6214:194b:b0:919:85a3:313e with SMTP id
 6a1803df08f44-91b554c3f01mr237876846d6.17.1791919891815; 
 Tue, 13 Oct 2026 12:31:31 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b97b3bb33sm32875346d6.15.2026.10.13.12.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 12:31:30 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:31:29 -0400
From: Peter Xu <peterx@redhat.com>
To: yuanminghao <yuanmh12@chinatelecom.cn>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 1/1] migration: shorten dst snapshot load thread name
Message-ID: <as6HEejBaZT4EK28@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261012084245.30635-1-yuanmh12@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012084245.30635-1-yuanmh12@chinatelecom.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Mon, Oct 12, 2026 at 04:42:45PM +0800, yuanminghao wrote:
> pthread_setname_np() fails with ERANGE if the name is longer than
> 15 characters, so "mig/dst/snapshot_load" (21 characters) is
> rejected and the thread keeps its default name.
> 
> Shorten it to "mig/dst/snapld" (15 characters) so the name is
> actually applied.
> 
> Signed-off-by: yuanminghao <yuanmh12@chinatelecom.cn>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


