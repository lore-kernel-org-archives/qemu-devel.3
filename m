Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E61C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyaHw-00079L-O3; Mon, 24 Aug 2026 15:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wyaHv-00079A-DC
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 15:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wyaHt-0006VD-Nt
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 15:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787599491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zDasYKY8q1bY5LYEDYETHKu/urM0LmqWOEDAQpQBf+8=;
 b=QehXsDXzj5wGEgIDXOodIEM7sxQ5OkNgjLWA3Yx3s56Cdegvyv4N6zKfgLPbGr2R95izAe
 L8EZtxDiNgSCUYI+HXTAu4pyvgv4ezguW/KPXWpSD5bZDWJonCIV+vj/TTbN8cIondeUTY
 h2Xh09C+laRmMjLSSN3nwJmONX5UqBg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-AVT1-_8EMUSMEP1SDnB39g-1; Mon, 24 Aug 2026 15:24:50 -0400
X-MC-Unique: AVT1-_8EMUSMEP1SDnB39g-1
X-Mimecast-MFC-AGG-ID: AVT1-_8EMUSMEP1SDnB39g_1787599489
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8efad04d884so71384466d6.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 12:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787599489; x=1788204289; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zDasYKY8q1bY5LYEDYETHKu/urM0LmqWOEDAQpQBf+8=;
 b=tTX+M1uBHiHCL6bmumwSWTdm3doKdiL9uiXry5Pb25VgTGDe5jMpqxqbACmcoiLdib
 C2n5qZ6owxTDu2e87q4oe94p3RFKowRaM/obNCTcYDlWvn773xTHIoO1aUksrmKCo5HU
 WJM7QpUKL1wrhqZfuUieBCtkzFTB6Yco0W0I9O9N7SVCuHyf5o+qHfsibUpH2enAsgQ/
 8IVH1kx34QAdBFJpytFo3+27rSLrpmMrzitmimYutnLY1B9+4GxtO8E4TGiFCPDGWFDV
 fS8ictjDZpXUWh9od7Jlj7GTfzPJnzP6ddpYqfgMhbB8ogK2pkLGkGGRBSWqOb3Un2ez
 BXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787599489; x=1788204289;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zDasYKY8q1bY5LYEDYETHKu/urM0LmqWOEDAQpQBf+8=;
 b=BGEUb0M0Gm/sF7A0VoNpJZtALHdO3Bw1CWUM3wp/p9yYGnxn+PbWoNX8cV/9NtJG+u
 ZWh+WBJ2aXhBz0nZP6Yq7sKJpyJl6nAPCr0/pK3MJyETr7KRGU5wcdO0DClSITHel5Xc
 6eFDR03p5LEjs97fy1kzetLIQtwWxZTdQiaACDM/gjiNp207VgZ2mTH5OsXT9yO5n8XZ
 ppeyJ6zmwfCCEZlj8pUcLQoQIr69/lKs6GC1WofIkDXnRh8nyCLqYElCbqIfUjSlTL+6
 +CDk7jO9hjxL7DI2JkKUo/9/NzmK2Du8Nj/SPUHs6qwv8Jr37/i7GrlHoqB/5+XRwdil
 eTMQ==
X-Gm-Message-State: AFuF++m0ExZ4lB713redPW/5o0WSoa8LtR2OT0sc3lFf8SmZ/THRPp+B
 5m3mTBXoKEbp3LxV6bMVrOadsh59nelmhlNgZZuEwge93Zq4tInRaHFhY1W1C7FO2dRQJAea/+6
 /vee74CHSuioMIJW47VZrae3oGZAdYvbg2/NnmBu7LX8BKoQxUIlYSx+3
X-Gm-Gg: AR+sD10utno1HGI9odDJyH/UAYXViwCc1vT+Jo1Vdw02ErrVoJ+cZ+dwxfgIGbul0vs
 iVUc8/BJ2s3TULC+eTOJCBNr1UUuAJ8K6D7f9M6xKxdW8ymlJgH9ZzrvaLMTO2y1ELFbs3e384a
 kMnzYL7btpu+iMyhI1FM6Zi+vQn6Iih2GRTsJs9u2qeQlrCVO9yzoIhtSBhT2uzQ7K97dsmxXXc
 dFL7jS2zVGFOJUvJedYMPY8yqqw/5LHCZirWDhPRWCrfOpMWwVhb62FzeHBI8bN4dt3jNpFFug5
 dnrnLXkNoRA+nfwevCAC2Tentj0F/2HghU50bTAWESQIRxP/S2qB6IBTt+wcpp/jpEFy
X-Received: by 2002:a05:6214:3207:b0:90c:8fdf:5641 with SMTP id
 6a1803df08f44-90cb790f1demr11682776d6.21.1787599489375; 
 Mon, 24 Aug 2026 12:24:49 -0700 (PDT)
X-Received: by 2002:a05:6214:3207:b0:90c:8fdf:5641 with SMTP id
 6a1803df08f44-90cb790f1demr11682156d6.21.1787599488796; 
 Mon, 24 Aug 2026 12:24:48 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c939332cbsm68616576d6.32.2026.08.24.12.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:24:48 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:24:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 1/1] system/physmem: Improve guest memory allocation
 failure error message
Message-ID: <aoyafAJi1iLQu2Ou@x1.local>
References: <20260822122710.3731595-1-bin.meng@processmission.com>
 <20260822122710.3731595-2-bin.meng@processmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260822122710.3731595-2-bin.meng@processmission.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Sat, Aug 22, 2026 at 08:27:08PM +0800, Bin Meng wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> When Linux refuses to overcommit a seriously wild allocation we get:
> 
>   $ qemu-system-i386 -m 40000000
>   qemu-system-i386: cannot set up guest memory 'pc.ram':
>   Cannot allocate memory
> 
> Slightly improve the error message, displaying the memory size
> requested (in case the user didn't expect unspecified memory size
> unit is in MiB):
> 
>   $ qemu-system-i386 -m 40000000
>   qemu-system-i386: Cannot set up 38.1 TiB of guest memory 'pc.ram':
>   Cannot allocate memory
> 
> Reported-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Tested-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> 
> ---
> 
> Changes in v2:
> - Rebase onto current master
> - Update the source path from softmmu/physmem.c to system/physmem.c
> - Fix a typo in the commit message
> - Collect Peter Xu's Reviewed-by and Bin Meng's Tested-by

queued, thanks.

-- 
Peter Xu


