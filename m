Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B78ECA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 12:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnOM-0005s7-Bi; Thu, 08 Oct 2026 08:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xEnOK-0005rn-SY
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 08:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xEnOJ-0006vK-01
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 08:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791463109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JyPBrFZ2Cn4YtPq93vNMwF7LBR/LAbXCMZYw/WX9VZg=;
 b=BNS9IW/SREEKv/w63SSpVi4XT3WBziRBZR+wc47kpfMARKAbm94oxb7N0VR8ZgG97lHf+E
 km7UPOcIvL+0AkOCAoFBeQ/3I1VYm9YAzuPOq+Yt7vygyDX9qXGmdoZUglb5jhV8xWBRvi
 zwQtwkdaHZc7+4NbbP7Ypr3OaUWRK34=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-EsS83V_BOLuCY07A5n-Wcg-1; Thu, 08 Oct 2026 08:38:28 -0400
X-MC-Unique: EsS83V_BOLuCY07A5n-Wcg-1
X-Mimecast-MFC-AGG-ID: EsS83V_BOLuCY07A5n-Wcg_1791463107
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso39718385e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 05:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791463107; x=1792067907; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JyPBrFZ2Cn4YtPq93vNMwF7LBR/LAbXCMZYw/WX9VZg=;
 b=pBCNRzD90N4YNrq7DrmuZj/9pHDmNPTPW0SeE5+yEtjbd1Xd9xy2yQhX407svswWrV
 TsKTun7J7xpqz4afKiiw7py6Pe3anKtdSPS63AArSu67DJD6v91z9thj7RVvPSIWrTBR
 reqNNHmLeSjEBOOQvlOT7bkhGbz/AwE2ieNQhcGYAkmcrFz0KWhACJlFYM3eFiT3umuD
 Wyi/lbUbtsIJwUz1x6ovHBPkSga0uXWnguYlgZj+7fiXkDALizBZd1yIzW+7DLuzEg9C
 pF2pfSm3yY/pFpgwyGndMiO+1s7Fozaj8pNK0GgJeM2dr6OEtNTRw0epjlb/Rq/EoRle
 wzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791463107; x=1792067907;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JyPBrFZ2Cn4YtPq93vNMwF7LBR/LAbXCMZYw/WX9VZg=;
 b=Y8yqqArXa/icRLPU6maUyiSVUnsrC6z5G0bWDT8lhMdq3bWZmh67Q5E9//p+u7guf5
 xOtN2d7aXU9Dpf2khqpYv+io+BuKM4MUtzB54/b7UyY8nsr20iLibfo1W9DyQfLuOxLk
 B1lc3lr2vrY/KNXnPRVDXMxy7SGyMYemUOO3L+SdjwH+NKk5O4Jk5r6I+iQUcrrqxXHZ
 YsfS786RiK+Xi9tHe4j0Li2DD7NSWFeM4OsQ9Jp4JHn9jeSObuYmtQK9UT/dxqbrpT5v
 2YpFGMDyQ4vx1Ch8kQRCNtt661Bdk8YLCpUVtPTS7oDxQTY636SI5GUxPVL1SkHIoy5K
 gs2A==
X-Gm-Message-State: AFuF++klm1Iuftk5n0I6PljnEhnveqW34NJECPbQHhzp7EOHIPC774HO
 uCffBEdIBBt6+VnhqENJT7w5DK081e7xMVmOdXZs6clx4dUzGngFlLw6ZQGOoAH7emg2/DWwgoF
 gVoIu929BJ88ZXd20j6Y260XxfU3IikQqni7ymUWMpUSuyoHoYInpLFd7
X-Gm-Gg: AYBFou3Ho+VeyoMYrJDTsfWouuJRNNpONOspAjdbEoUXYdLQwsqvVRxrVhDuFze5zcR
 32LBay1vU7vVq/il/JWtVOaYGUH9tOJoHaWHFh8RqIJtmF+ji0SasjlGnyLAerrAe6bJuuYkqH6
 zZLNjtRr9A89g5Cc64ZRBq9xoYHqlC+n5ZWT4JtisPR8qhTVTrF0ZAuIHDJ0kCrDaXsClgZLyKb
 nRokw/G8KGHAqHpZrUBBQF7GW0TOFW4yA3xFENCHQM3LfVF+LtmyGe65+B1xCKpoKnM5AMNSfjn
 QLAr/HCSnUUUXD9c8RZn/8Yp2oDphG9/3tz66uFID1gJJdr5HdgJYgchCbJvk7E5rjngDYZMmYL
 z0xGZCa9yO4OHmT/deQZzKFYwQhW4dcrGTg8=
X-Received: by 2002:a05:600c:4e43:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-4a18045597fmr88682245e9.21.1791463106761; 
 Thu, 08 Oct 2026 05:38:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4e43:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-4a18045597fmr88681865e9.21.1791463106411; 
 Thu, 08 Oct 2026 05:38:26 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17fc4a588sm120085805e9.1.2026.10.08.05.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 05:38:25 -0700 (PDT)
Date: Thu, 8 Oct 2026 14:38:23 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Tommaso Califano <tcalifano@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/usb/dev-mtp: Fix assert crash on short
 CMD_SEND_OBJECT
Message-ID: <aseOsAfB3GuyghJF@leonardi-redhat>
References: <20261008122936.45081-1-tcalifano@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261008122936.45081-1-tcalifano@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Thu, Oct 08, 2026 at 02:29:36PM +0200, Tommaso Califano wrote:
>In usb_mtp_get_data() there is a guest-triggerable assertion that fires
>when a guest declares a large object size in CMD_SEND_OBJECT_INFO but
>sends fewer bytes in the subsequent CMD_SEND_OBJECT. The assertion
>compares the declared size against the actual bytes received.
>
>If the guest sends CMD_SEND_OBJECT_INFO with size=1000 and then
>CMD_SEND_OBJECT with only 50 bytes (short, non-64-byte-aligned
>final USB packet) the assertion fires, killing QEMU.
>
>To prevent that is sufficient to remove the assertion, because the case
>is handled by usb_mtp_write_data() which returns RES_INCOMPLETE_TRANSFER.
>
>Fixes: 3e096650a64d ("dev-mtp: Add support for > 4GB file transfers")
>Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3993
>Signed-off-by: Tommaso Califano <tcalifano@redhat.com>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


