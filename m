Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0482CF3963
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 17:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srLDm-00066z-Kq; Thu, 19 Sep 2024 13:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srLDj-0005wZ-6Y
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srLDg-00019Y-4I
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726767931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Oy5NalvK6J6W/GptNSPGW/2Bna+PFbW1pFSxfxu2sQ=;
 b=ivrPIxUrR9jmV9SA91kbw80wMPUKj0QDvxDO/2n7JlbqTdLfeB0RnwBq57MgPxrfV0XLE1
 SaSK39kq2LIDepTYtk/0rb71OQOHC25qywZHPwe29W6nc4aNV5vjgt2aPuXkKDdDcZh0/a
 ZN2qqLLO1NhLCapOmbCKDOR7SE5aVnM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-Uf4_8HawN1SXLKZKsvuoTA-1; Thu, 19 Sep 2024 13:45:28 -0400
X-MC-Unique: Uf4_8HawN1SXLKZKsvuoTA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6c358223647so13687566d6.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 10:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726767927; x=1727372727;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Oy5NalvK6J6W/GptNSPGW/2Bna+PFbW1pFSxfxu2sQ=;
 b=PNAZyvsFXeNfXAMHv/fsbNQ0G23iVxBCvKbeKeBlTkerfX+580xWB8dlYVzXJ3snRG
 J2CV3p1dl/l+bJBKVICkVyeZZzFFUijMGfCKCik3VDJed8UEiT/xWwOvROTvgDGylWzs
 otNMhvuJ9FQIOgxB5VkHRH9dQwpa2lR8/SFkrO32QQs4jU0iq1YVpGYFtp/lmETIaMKh
 4/+jAflL/ebo4os0wnWQ4FbqnYDH5/KDe/6JokimGcy/NkHjxQQ3dBPrBcWtgoerryAx
 UZAaTuGOlsyCIYu9exCiSqVi+rXu9S/oxNCzSWbmkTfoXJnLiygtH7s3noztrNv+1EkD
 Qi9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX17fVVMwq1W7q/A0XvsU5XBsy/ePI+5y+zoDjwfMyIYzYZvvg2g8KuotyVxY8QoT+nRNNsO2yv8JkB@nongnu.org
X-Gm-Message-State: AOJu0YzuNi1j9dW+M1CixRI498RnvL4mV3ugk9P66RWdjs7bc3bHjT5q
 +3Ms8Rp69xkXdHPXtnRtf3PTPAZTmWbm3DgTW6BQDA1efChytKX2Yhsg8FL1rMulWA5nv6FahDa
 xUWUZjvC8iEp+a8NoDJW1ba6kslaN08X98EPLT3uKzLdU4cv9EKe/
X-Received: by 2002:a05:6214:3207:b0:6c5:32a5:567a with SMTP id
 6a1803df08f44-6c7bc6dafd8mr1929126d6.1.1726767927555; 
 Thu, 19 Sep 2024 10:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBvFgmiIfBAS7LhtomYooecUZbKRLhmQHKydlgN1iR/Ulg9XIJsLElDhY+6JY9ffhj90COpw==
X-Received: by 2002:a05:6214:3207:b0:6c5:32a5:567a with SMTP id
 6a1803df08f44-6c7bc6dafd8mr1928896d6.1.1726767927285; 
 Thu, 19 Sep 2024 10:45:27 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e557a79sm9528396d6.76.2024.09.19.10.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 10:45:26 -0700 (PDT)
Date: Thu, 19 Sep 2024 13:45:25 -0400
From: Peter Xu <peterx@redhat.com>
To: dave@treblig.org
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/7] migration: Remove unused migrate_zero_blocks
Message-ID: <ZuxjNfoLYwTXt6Jh@x1n>
References: <20240919134626.166183-1-dave@treblig.org>
 <20240919134626.166183-3-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919134626.166183-3-dave@treblig.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 19, 2024 at 02:46:21PM +0100, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> migrate_zero_blocks is unused since
>   eef0bae3a7 ("migration: Remove block migration")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


