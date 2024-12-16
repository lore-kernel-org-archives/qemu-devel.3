Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A65FE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDYm-0001hy-CQ; Mon, 16 Dec 2024 11:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNDY1-0001cV-Vr
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:02:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNDXu-0005bA-Gf
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734364928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jUezM7Yuk+cPxurDXaWs/3FxNcYR6EdeumJ/ltVmEKQ=;
 b=YWVNFM4wIui9JUdGBrV/B+3oAfjIU/74WlrPilzU7WCJIMI2cN6fdC9fiPmYy9dTD5An5x
 jk65E9whfZWJaAw0lV9IU996Fnm4J7Z5guUAq+AHMbj9UCFqqdnObxq6/kemj/y1kZj955
 Q1kfXyw1a4VCEZ3V6R3iqQfrLfhRzqg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-JZEShMwSO3CqyS3bKmaIbg-1; Mon, 16 Dec 2024 11:02:07 -0500
X-MC-Unique: JZEShMwSO3CqyS3bKmaIbg-1
X-Mimecast-MFC-AGG-ID: JZEShMwSO3CqyS3bKmaIbg
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-844cffcb685so358669339f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 08:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734364927; x=1734969727;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUezM7Yuk+cPxurDXaWs/3FxNcYR6EdeumJ/ltVmEKQ=;
 b=nk/zCpMLZa8tf7Y7UXiHtPZoBVZpVB0S9jweJ3YJ22sWLluwE67YgLC/7N/WvwYQOr
 kAuIrVaBAmatYiceDEuv8vAOV5Nxim9jZcV/CIl9ySpylWZRGETCswCbGram8BMUlXUW
 3IpaOuSQxc9erb8mGZ+AuNr1R2YFM/kA45ykHKOPuvDxYKoHf8h/o9uA/+gB31I7BxDx
 56pJrDPdspaFpp0hfYdrBtoBfxrdLBOoudcuGrTEYSc+OwQPgWVst5QjemCW2B+tczQW
 YRv+FHbfpAZZM5Brmkaqi7BXMBJkADpVt+M6v9c3lwdw/udhy/tGs0diYzrL5Rzrl1Yo
 y73A==
X-Gm-Message-State: AOJu0YykSVb/MgafF2fb3APcBK1vO1L4UUBWilSg6qa+NShLlONyqxFc
 LHcUeH5d+yNukPrXg/Nj0QsRdlC/F5rVMJIW2vXqOF3MZrB8LJVKUPJgfIZ4CPlxFCy94KOm0Rs
 gFPe7/1lk1NRfwsMLXyuyXt4YINcOuDu3EcJesvTMvzAkM2Q0VKmN
X-Gm-Gg: ASbGncueBQFUN4YUqKpVFiwzUbJSYtwssJagZpONHoH2xsSeR53pd9j2o/7PGoOr8rW
 XdWMcudaXMufqWJq3X2j8osEVTSN9NKv625eSu+E4C4+jUuQizC0ZM1w4tPKyWn2W+5YT+JqLu8
 SlNtlfnAh+MY6idA7m7poKIEY1ze5CUXOE4NDtSJyaPl5P9fu0j9+89cl1OBKhcjdpTmEx/bMOI
 B+ofRdoWayVM9jZy/v6v0g2tMZ8R6YyE033DwAR3zWwJbb3zG62EfyLxhJJhCowuepHfmKma4Yx
 /7/+N9EgiI1ezIfSXw==
X-Received: by 2002:a05:6602:1494:b0:843:e89d:b62b with SMTP id
 ca18e2360f4ac-844e8b69bdemr1214027139f.11.1734364926730; 
 Mon, 16 Dec 2024 08:02:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJG0jXMMZAc0OiPem4tdjF0rPMUNRZmVsHW7yhIvyO3yOYiWp1lgSoOXyu4+Or/kaw07a8Ww==
X-Received: by 2002:a05:6602:1494:b0:843:e89d:b62b with SMTP id
 ca18e2360f4ac-844e8b69bdemr1214019239f.11.1734364926065; 
 Mon, 16 Dec 2024 08:02:06 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844f626b622sm132851539f.15.2024.12.16.08.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 08:02:05 -0800 (PST)
Date: Mon, 16 Dec 2024 11:02:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 1/2] migration/multifd: Fix compat with QEMU < 9.0
Message-ID: <Z2BO-3vdEyNrMhhR@x1n>
References: <20241213160120.23880-1-farosas@suse.de>
 <20241213160120.23880-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213160120.23880-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Dec 13, 2024 at 01:01:19PM -0300, Fabiano Rosas wrote:
> Commit f5f48a7891 ("migration/multifd: Separate SYNC request with
> normal jobs") changed the multifd source side to stop sending data
> along with the MULTIFD_FLAG_SYNC, effectively introducing the concept
> of a SYNC-only packet. Relying on that, commit d7e58f412c
> ("migration/multifd: Don't send ram data during SYNC") later came
> along and skipped reading data from SYNC packets.
> 
> In a versions timeline like this:
> 
>   8.2 f5f48a7 9.0 9.1 d7e58f41 9.2
> 
> The issue arises that QEMUs < 9.0 still send data along with SYNC, but
> QEMUs > 9.1 don't gather that data anymore. This leads to various
> kinds of migration failures due to desync/missing data.
> 
> Stop checking for a SYNC packet on the destination and unconditionally
> unfill the packet.
> 
> From now on:
> 
> old -> new:
> the source sends data + sync, destination reads normally
> 
> new -> new:
> source sends only sync, destination reads zeros
> 
> new -> old:
> source sends only sync, destination reads zeros
> 
> CC: qemu-stable@nongnu.org
> Fixes: d7e58f412c ("migration/multifd: Don't send ram data during SYNC")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2720
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


