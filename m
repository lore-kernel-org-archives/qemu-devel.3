Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E843C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wltiR-0000Bm-53; Mon, 20 Jul 2026 15:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wltha-0008HE-0I
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlthX-00014B-Sc
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784575854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GdyvgI4wASfLWra4LV2rz9TPaHvFuUPUT4SwJYCdQGQ=;
 b=djgaORvdNfDYIV7zwhhv1xoA+0LeQDFnCmOw2mPoJkRpjbT0HhBZAo0ijtweykQ7wTIZwB
 30Kx84Zht4USKcOtwdRCCTjjsSmvRCS/WPuPwW/J5LGr/SuNKPhNjTvZY3P55/lGlSkeuR
 7S1K9Kz6PHVYJKMG7a8Sfhs9EvDCgtU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-PEjdoRkNPAaJWeyBuyOS7g-1; Mon, 20 Jul 2026 15:30:53 -0400
X-MC-Unique: PEjdoRkNPAaJWeyBuyOS7g-1
X-Mimecast-MFC-AGG-ID: PEjdoRkNPAaJWeyBuyOS7g_1784575852
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e606e8f3eso1509893285a.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784575852; x=1785180652; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GdyvgI4wASfLWra4LV2rz9TPaHvFuUPUT4SwJYCdQGQ=;
 b=Anqc7XsDe77gCyiBJEQbMLSlWKRlBh5q1AYoO5bzCRuON+VrsFBAa+Ug4ellk40gwW
 2AGDgEHOQZmd23M5g4siIw+goERK8bo16UaYLVNFHXZvMtBlEu3dnm+n8BSvgZTCaS6e
 1t56raXbNIh7MPoF93sQkATY+kDYVyVA0+GSdLpc376Hk47QqJFc70HUGRIBjcqllq0x
 mtqdZI6jszDYl4aNw+DgJafCJDjmH4rwSXx6pupgWOT8R9W563qH1DC0fi6wzY1QkxuA
 /75kxbye8NBthbn3xEnLDysolbiIvFVa9PKV7/VxTMYcwceDgwQ4/XuE6OY7JNr8HXEy
 hOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784575852; x=1785180652;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GdyvgI4wASfLWra4LV2rz9TPaHvFuUPUT4SwJYCdQGQ=;
 b=Og0096kzyTpSJBwbh2hCd11Wm01/ZYwjKXpFYwrbbMPAh6uUKoUjtEdgAJyEl963Bz
 1v/X2huC93kPN04NjcWv79PJ3Uh3+jNWUvhB8bZCpiWGPIUvZ9EKEhDFwcBWg7ZYkRXt
 IPpOHQ3IiTw0hrFU/UBVO8weDl35yPb0kDkr+vW8W13v7A90oj7QuO9VW1RPejfT2ftb
 sMsdrS1cAEW/DvaFNB2lW+ePqPEmvl/g4qILfLPriIC85VoCu89DkS3W3AkZ+I5gLtfV
 G8R3d91H5cbXivb4aTVDw4LFXXbfUDixoJEionNE+k5TnluoIQxCEa48pxLiR6UC93PK
 XvZg==
X-Gm-Message-State: AOJu0YwfShlmC+8un25CPGwaOTl5E5rIw61p1Bj5VTGEVtzKpYKnO/L1
 zmYtCx0X9lbYpDTOxkLFaDoxrLFklhzB1lbfMJsUZHofSzhP1HJaKxsPklG2cjspCnBLAn4OQQI
 zPA2bC+QWDXo1+tjX0zrk8CJM0RsnK4HJRnBthhIUNDV73Ock/eOMfdKx
X-Gm-Gg: AfdE7cmZEPCgZRL8JC/t5JzbwUbWKsxHhsry6zAqK/9nZ/fwUtqp90a0YDFxrIKR87G
 SNTefSYRIdbeLOqSwHE4kljvaOvN1zvEXuQZ23jFOultD2PAOOrsHOC+NdJrzNMZyR6a6fqI1JT
 XrFSrs6WVYg61HYycVxG7J6xUrwdHkDZgmdmqTW6q8QrXb4XjoXdq9859tCYTXIbO9NqyZ1SNSd
 Be1/5fXrOXL9UIGaQ10MAQnYEY+E8MArGyKn8mNXl5f9/F8MLe48w1oNaKFTCKwy56/nE/X4QmO
 rAmvKdnr210L0AmqBnvTKbth3FzCz/AEozVLadwxGoMVs/fePIxiaE/XED6UM5qmqOP7
X-Received: by 2002:a05:620a:470b:b0:930:987d:2732 with SMTP id
 af79cd13be357-930b41e0fe4mr1478643785a.59.1784575852211; 
 Mon, 20 Jul 2026 12:30:52 -0700 (PDT)
X-Received: by 2002:a05:620a:470b:b0:930:987d:2732 with SMTP id
 af79cd13be357-930b41e0fe4mr1478638985a.59.1784575851561; 
 Mon, 20 Jul 2026 12:30:51 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b531d937sm930087785a.21.2026.07.20.12.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 12:30:51 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:30:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v3 10/11] migration/tests: Add test for fast snapshot load
Message-ID: <al53X97WJXx1Hrlg@x1.local>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-11-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714141547.1268000-11-aadeshveer07@gmail.com>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 14, 2026 at 07:45:46PM +0530, Aadeshveer Singh wrote:
> Add test_postcopy_file_mapped_ram() to test for saving a snapshot in
> mapped ram format and loading it using postcopy/fast snapshot load.
> 
> Test is similar to test_precopy_file_mapped_ram() with additional
> start_hook to set postcopy capabilities on the receiving end.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


