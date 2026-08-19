Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3700EC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwjqu-0006Ua-5n; Wed, 19 Aug 2026 13:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwjqq-0006UK-DM
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:13:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwjqn-0005qp-SP
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787159593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o4BO5irhIyZDWEJJVtO4/Rddtp5PXrP35HKpdvlx/5U=;
 b=BXYbIBD698mc592Op6KjK1eIz9za7e93l3hIrsFhz/766l50ynclBb0xFbw0L6GTqvViAK
 12v1vOfMBrGdcgFmhTHjDvfwLbggqHdNK0y9592L2uMAgSZRPTFYOAmsDmkzab/+JRwsY6
 KfNhkZjV3tPNWCxGG6BxrOg3a6xm+Go=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-pOm5hGlWP1qCRGFAVvqRRw-1; Wed, 19 Aug 2026 13:13:12 -0400
X-MC-Unique: pOm5hGlWP1qCRGFAVvqRRw-1
X-Mimecast-MFC-AGG-ID: pOm5hGlWP1qCRGFAVvqRRw_1787159591
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47fd4ee0ac0so1073510f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 10:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787159591; x=1787764391; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o4BO5irhIyZDWEJJVtO4/Rddtp5PXrP35HKpdvlx/5U=;
 b=SOFPRZcqSSGwVZX01nw+2EIpxOwvAxxhJT8u32M0XWdIiH93bKfOp3M3uGPMUvrAZT
 oDyLeHG/3qsUsDcaJowDgMws23FXtn9vJMsPI8X7H0cyYkXPDrMomXiPTdsudGmi3jxh
 KrBoJcMyVEku8YUTcnmV8bPC01t8z86NPYAx7YlRv012Zbk14961idnruplg21cDrWpF
 9nYm2FeFUXZt1E6Q33QzrhNh20hEEohkQoeFMoQM8mdJp9N2gLkdTNS7K4ISTh0KVePo
 iLNsAnfb2yphOhoyDnBU8Rw49vDwoC6xo84+kg19+b+EAtOCEthdWs77f3JPLA8Wkd+S
 PfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787159591; x=1787764391;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o4BO5irhIyZDWEJJVtO4/Rddtp5PXrP35HKpdvlx/5U=;
 b=jNNME9x81ADvAc042HLvS+p547j1ZWv20hB3OlpIN6vvnJSvPRm/4E3X9lD0ZzHm1r
 g/AyvPUnLjs8O46XqIanNGDNFarxTC1CRpmZ1eK/DqfVHeTGI2I6xEC3yv6H9zhTjdcB
 Zp+ggzIRSw3nXQHUJUW6QVgS9o8I9Zb2p73136i4+kqssbLL7vws1d2w3LsCORyv1olX
 O36kiIdTwYeYoRvBAgkTOqf4OVlyga58j+YKfDZkqHeqIgHtARqLjKczbIA9RLP95UES
 LfU4PeChdI5wlT7w+c/WsxeknbVWgyEr3PnbSz0Ah2mlPd+4qGCT/lE9ySmiLQK1K2T2
 A4qw==
X-Forwarded-Encrypted: i=1;
 AHgh+RosP19nWMX2skVJ9pH3Zqw2ucJnv1cz4gBxreCCpp6yZIz2EUxnDU+fUs8o1VxM5zeaYb0mr/ZM2hCh@nongnu.org
X-Gm-Message-State: AFuF++l34f0Ff8AkSvmAjaZ9TIVRX5Xb7PZAdhwOZaoHMVoQXCsou8uT
 PUMViOCpYSXX0A+H6DjepgfhqZ55nRn+38KHTaBHs0APQOsx7UZ5sCTbQsSR55ADGmDHRaCTXbG
 sL0nW2Hl28jffITfORntoy2/itkDUl/3ErRjrcBFOkUZkk0RhAyAK55PA
X-Gm-Gg: AR+sD13K5aE4Cxa5pGM61XtF2b+SrlAIWZ1ktdCQiat3k8wLZwEiGKiWTXr/Q7zUgg4
 sPTORh4sb4c2uYM7L1RilTEspGRaUjN3FU+jx78Jkzk4+c56p9XOyTsS3aEntcEf75Mq8EeCWLK
 Lti2LaMCb9TfiIWFkpFFnZfh2BCd8ZZGfP5Wme5y87Bo+A3wiDebzRplRMdgmMNIXUEofVp2ugl
 s/7iXEETpxsg6qUGP81x36+vtNekkj9tGnCULWUanDAtP1tdTDwux2vMTOhsASkbSxA8rHTw5vH
 J3e8BF3cRSAnf+b4PXeC/cqOjsHCehRXWZ8UpmjvpvdM2qoEvGtVCoIarfFTOr1LUjr5
X-Received: by 2002:a05:6000:4b0a:b0:481:5f3c:39d4 with SMTP id
 ffacd0b85a97d-482b1e84439mr12610224f8f.1.1787159590902; 
 Wed, 19 Aug 2026 10:13:10 -0700 (PDT)
X-Received: by 2002:a05:6000:4b0a:b0:481:5f3c:39d4 with SMTP id
 ffacd0b85a97d-482b1e84439mr12610103f8f.1.1787159590505; 
 Wed, 19 Aug 2026 10:13:10 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c45f1sm6793024f8f.31.2026.08.19.10.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 10:13:09 -0700 (PDT)
Date: Wed, 19 Aug 2026 13:12:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: Re: [PATCH v20 10/15] migration/channel: check that transfer is UNIX
 socket when "local" set
Message-ID: <aoXkGOijYjxMzfhy@x1.local>
References: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
 <20260729091334.1863155-11-vsementsov@yandex-team.ru>
 <amoJoAyhymPgvyTR@x1.local>
 <b9957dda-c0ee-4081-8938-ecc5a50aae3c@yandex-team.ru>
 <aoNXx0cjLgIP7RBg@x1.local>
 <9fc39a84-15ca-4157-afca-f4cd22bfbdad@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fc39a84-15ca-4157-afca-f4cd22bfbdad@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Wed, Aug 19, 2026 at 05:57:20PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 17.08.26 21:49, Peter Xu wrote:
> > On Mon, Aug 17, 2026 at 09:15:17PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > We only need to touch migration_capabilities_and_transport_compatible()?
> > > > It should work for both, and fail QMP commands directly might also be
> > > > slightly better.
> > > 
> > > 
> > > Hm. Actually, migration_capabilities_and_transport_compatible() only sees
> > > the parsed MigrationAddress, before any QIOChannel is created. At that
> > > point we can't call qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS),
> > > because there is no ioc yet..
> > > 
> > > So, at least, we can't check, is passed from user fd is a UNIX socket
> > > for SOCKET_ADDRESS_TYPE_FD case.
> > 
> > Maybe have one extra step for FD with socket_sockaddr_to_address()?
> > 
> 
> For this we need an fd itself, but we don't have it at the moment, we
> get it from monitof_fd_param() later (and we can't call it twice, as
> it removes the fd from the list).
> 
> Now I think, correct place to check FD case is migration_fd_valid()
> function, which also called both for outgoing and incoming paths.
> 
> So, check that we use either UNIX socket or FD in
> migration_capabilities_and_transport_compatible(), and later check
> for fd to be UNIX socket in migration_fd_valid().
> 
> Will do in v21, if no better ideas.

Sounds good.  When at it, we could comment in
migration_capabilities_and_transport_compatible() too mentioning that fd
type will be checked later (after fetching the fd handle).

-- 
Peter Xu


