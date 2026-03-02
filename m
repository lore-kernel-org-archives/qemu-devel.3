Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6A5EB362C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 20:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx9Xu-0002iG-Ly; Mon, 02 Mar 2026 15:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vx9Xt-0002i6-4n
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 15:07:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vx9Xr-0007Bj-Qq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 15:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772482030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yvfEjQUA5ozHe2/IMBmr9sQ7Od1mncrg/lL+a/L1038=;
 b=exb9b4mXctkyANBHQld/U5hCSV5gtqBtzWufZledymWSiE260Y4iqFz25wiWEAsFEk/F9a
 M585Mo8CZM44bM7eyEau7hMcd3UBHDi6lOt+GbBkSRYb/2zdx8r3XZ/36snqCdScd+4HW0
 ltydvqDWjtsFRDv0eZ7qcEtNLtkelDY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-_5di8xq0M1-dISDnMe9tLQ-1; Mon, 02 Mar 2026 15:07:08 -0500
X-MC-Unique: _5di8xq0M1-dISDnMe9tLQ-1
X-Mimecast-MFC-AGG-ID: _5di8xq0M1-dISDnMe9tLQ_1772482028
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5033b4d599eso478059901cf.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 12:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772482028; x=1773086828; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yvfEjQUA5ozHe2/IMBmr9sQ7Od1mncrg/lL+a/L1038=;
 b=PhlkL0Ywn5u/uI6YTv1eGZixa+cYclah5ScYprjekSl5VvI2OOVIdl2UzVjPp18nAr
 YkD7ismsA8IRJIiHvVb84mRHYErMnlPwd7KknmM1gOwLMOtA+LMnMkP4GPFpgQpjeh6B
 G/qMQ4bCKTsf+fli/moioRMN7KKzbl+vF0mowR8zdS0FVyguPOtPcVD83JKJ2nudybEn
 6joFJp+OeOBelLGHN7r16MnOWhoXiqVhQIZU+4LnLJ7X9oLMk3RnB1f7DCSPung1mHOY
 1O5mJlQtjN1tVkrT2K49pOYRVvWBFEAAZ3gBGSX/ZsS/bcA+SUBrRGXwUhZWI/psZCZQ
 sujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772482028; x=1773086828;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvfEjQUA5ozHe2/IMBmr9sQ7Od1mncrg/lL+a/L1038=;
 b=pJBC/us3UI8sRsG1rW9fDsN02+Rry/oprRfBL/GR6CDfELmc756iqqNzTO4Os50YGo
 X6IhPbKTxlZHr311mkKcIEEUFscAVbh/WewnHWjHgIYAADkbVqDWADIjrAVpkitrJX+t
 lSejvsuaCp5cE8cwkz19yW+BwZkEZDs6V1FoaMrHDT/vwR2XNVlP2ym8/te45gSsfOGN
 4SoBzKu8qvV1KOwI4e7PhbElaagnYDtsSzxvXuccRCAE2ccZE4N3vBBNNX39hUk+eZRq
 sVITgKWHq9km3SuWn+IwMdGsynTglhwL7jPFf8QykP4mlx1ZSN7P1+9JarjA+iF7tLnQ
 2HCg==
X-Gm-Message-State: AOJu0YxsNQJxcwLP6WkJSZa/HQR9kCFzml94Kz4tbkzsPBdSiFt4/KaT
 GYZEmTusFGjqratCQTVdSdgDpKj0yYCsoZ1w9HylkK4JqsQzc2XrM+Jf2HKuBVGGM/Lrnswcfsp
 rP83C9tFb0YDLNvridXe6kg5RqOb/apVbMgC0euef8L1NPrO0MIA4uiny
X-Gm-Gg: ATEYQzz0Hs1JPvdLNNc8h8bX5aJhVpSDj+mNqredRGICjbNtDdH0Rsyo8eEdKXGs5IE
 kqrtFtZHSfGDVBfCp4tQlZqA1py26E8fsRtnxbWSvIjj9OejAW7mR4vjfDyiWlOHdpg+LvZa03b
 1Ckk8kk4VszIxp6pmgVrn3mMHHoKk26bGOVsAVzGS08bbQcjaD34M7taFaaK5nXANNtroxOi62p
 t77xwgckIiyKSo+GqPBPjDewGF60Y54TQLKfk4CxCzr7wOkxfs0pq415hgf9XR49n6rmYEAI5In
 wmQb2Yon+D/ukAhvKpM92J/Cl1W981hk3vmP5IRs+MegTwRGwmEOqmq2FHXh6gY3+u/G0Ttb6bl
 b/1pMs848/dEyqQ==
X-Received: by 2002:ac8:584e:0:b0:4f1:b9be:5111 with SMTP id
 d75a77b69052e-50752982bfcmr177458481cf.48.1772482027959; 
 Mon, 02 Mar 2026 12:07:07 -0800 (PST)
X-Received: by 2002:ac8:584e:0:b0:4f1:b9be:5111 with SMTP id
 d75a77b69052e-50752982bfcmr177458051cf.48.1772482027500; 
 Mon, 02 Mar 2026 12:07:07 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5074481c0e5sm128940431cf.0.2026.03.02.12.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 12:07:06 -0800 (PST)
Date: Mon, 2 Mar 2026 15:06:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v11 19/21] colo: Use file lock in primary_vm_do_failover()
Message-ID: <aaXt36L664YyBz63@x1.local>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
 <20260302-colo_unit_test_multifd-v11-19-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302-colo_unit_test_multifd-v11-19-d653fb3b1d80@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 02, 2026 at 12:45:34PM +0100, Lukas Straub wrote:
> Take the file lock since s->to_dst_file and s->rp_state.from_dst_file
> may be changed in the migration thread.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


