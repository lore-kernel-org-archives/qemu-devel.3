Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA9CC5472E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 20:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sifwa-0005FX-HJ; Mon, 26 Aug 2024 16:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sifwY-00059A-PS
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 16:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sifwX-0003j2-B9
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 16:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724702639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vigSQywm5bcrVtxZK7Jm6c4tM17gdKpJLriRELIYpwI=;
 b=BcnVepjITyO6Kzg9nY6rVSvqDq4trEIKnsrEQWo3euB+yW7YQVCCMCiDkWqfUO5Y8HlndK
 PFHooJv3qYoIeQzZ0HAKiMNCTH90biNHflYunXCowlxFSHw0aeUhgdLBnK0se0ZTyfTdMb
 /lBL4r2DFw/yu7Av4e73y0blkB0F7Cs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-D79ozWOLPomFvBV14UymYg-1; Mon, 26 Aug 2024 16:03:58 -0400
X-MC-Unique: D79ozWOLPomFvBV14UymYg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a1d40f49f5so607625785a.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 13:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724702638; x=1725307438;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vigSQywm5bcrVtxZK7Jm6c4tM17gdKpJLriRELIYpwI=;
 b=re1Se5fPUeXUBDVHfLFPLIcDMwuPh9RLPCEbG2DcCXzdod+3cVFYEeYb4WKv6zNnwc
 +tFL0fwRpOVXcIfsztPF80250oOAgRh6RphesmlchllM4dbHoT3VEe+s/uRnEJ4CPKQj
 kWe9XOGerc2WSm2ephcbL7RysOqTkjYSg6z2HG6G8MdGzqP8BUEV5wqUsMlcDJzDY+V5
 ubRvqg4z602+5CVGqHOIGQgS9Fgld6u/t2I3FXUxQHIY0lNKn+tx3p6Qs1lWEPTQRMvT
 MJ5mq3l6ZRXVTmqgsct31aKKu8gm2nhZ3IB2eSwwFG/ndUeEErU6edMJbDr3wYYWA2aj
 6C1A==
X-Gm-Message-State: AOJu0YzHNbMy5niPgIrHVHOJR5mtU3ZKbjVA0vA6k8gCR7dQ3U2LIChH
 jDIg02M12LBcXAkyw6kNWKFDMMnDEovSgst4rLQcLLbYrrngOa95oqz8JmtuZ2nepATTQzSvUEt
 C80S8mPjD+O6m3a258Olx/hFHo/FFUHHu7TxxNhXouwYkCNIzeb4E
X-Received: by 2002:a05:620a:4710:b0:79f:947:8915 with SMTP id
 af79cd13be357-7a689709ecfmr1434301185a.29.1724702637811; 
 Mon, 26 Aug 2024 13:03:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgTPhuBiyD8RbOI61yVCY/YGyNv9U2Bz/D/zklKgxzMIod2AdxnZ6hIgBf1zHoqK640HxPXA==
X-Received: by 2002:a05:620a:4710:b0:79f:947:8915 with SMTP id
 af79cd13be357-7a689709ecfmr1434299085a.29.1724702637509; 
 Mon, 26 Aug 2024 13:03:57 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f362739sm487115985a.68.2024.08.26.13.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 13:03:56 -0700 (PDT)
Date: Mon, 26 Aug 2024 16:03:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 17/18] migration/multifd: Make MultiFDMethods const
Message-ID: <ZszfqgvwwWT3dmVe@x1n>
References: <20240826195322.16532-1-farosas@suse.de>
 <20240826195322.16532-18-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240826195322.16532-18-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 26, 2024 at 04:53:21PM -0300, Fabiano Rosas wrote:
> The methods are defined at module_init time and don't ever
> change. Make them const.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


