Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C292CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 19:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFzrB-00038V-38; Mon, 03 Nov 2025 14:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vFzr5-00036p-Vn
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:04:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vFzr0-0005oS-Ur
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762196661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HUNwQ5fjmSvoqmn2Oeg0pGg7iX8z8y5TbhVjDvquhPw=;
 b=h5lsAL4UWiI+tbdNTyoDq1TtCMAwIvjlRBu/vy/PTDpS27K5W86A+qVr3twl/hMbrnqgD1
 +cgx38qUlBqRJK3YmIvET9XZ9gMstFMbRD/6dEwIPLsr5DVAVYfAENEFA03fzdocpNlIEm
 sfE8itr0Rq+SF2KzlGLefyeB2m14Czo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-kVtHIfDAP6esxiORgPZZOQ-1; Mon, 03 Nov 2025 14:04:18 -0500
X-MC-Unique: kVtHIfDAP6esxiORgPZZOQ-1
X-Mimecast-MFC-AGG-ID: kVtHIfDAP6esxiORgPZZOQ_1762196658
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-88f81cf8244so2063226885a.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 11:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762196658; x=1762801458; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HUNwQ5fjmSvoqmn2Oeg0pGg7iX8z8y5TbhVjDvquhPw=;
 b=VVPGd3fHj3XpitmMrdWAfRuoQioJRC5fIDvYSuKjboH2VxNyHAyWMvskTTuq2o3E03
 jiNmPQL5QZrEwXp3oMPUR6W1tYr8zH7zgESaPZSZF0iemdKFBfwuYfg9fH3oNh9uRvn4
 6gTVieyMWpJGmCn6LGsg1dCrh6Dx+UDB7khAqfBv+puWtSFxmY5ktU+4XH5PrYlUg2Jr
 wHH+FX3zQrll1p0tUYwXObOKhMS6C4px3WFPe3meeZaCsXN08e1bh1jCigVJ597OBWGH
 xGdCoqvRip3GCNVDIQLEos3+2bWt6hqoPM0kmFmm1rbwrYi2mN/yLa/zGmAi7ujMTavO
 jBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762196658; x=1762801458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUNwQ5fjmSvoqmn2Oeg0pGg7iX8z8y5TbhVjDvquhPw=;
 b=pgKzxmF0Z9PvVbnJBoRMw4TZ4dLIo3B9iOVxHpvTOFbb6qL0VnynDy+vYd2nKbQKjX
 KBpgJXq0ezZQzKarwzAsKOGg6HRECiDRuqUQsELXf9WdS9+znJylrPAnwSxmR8ulWFwd
 lZRf0Fw+r8zaiHfkFwVqmGjJzAJuH4KsRE79x3Ee5n+j05MCiA6Vo6Ohw1vnxs+WIpBn
 IkkOF/0yTvvHXOPiP7DjCW+1m4yh+Q+sKr+e3z7ipSai2UOkea+DSfvqybJwHYhxdIAy
 0+yzCc+SkHErYo+fBsorPNtXgKvrO3MtaLBOUf/vQKwUvMKJlKNWTZQqk97ScdMLzDeq
 tpUA==
X-Gm-Message-State: AOJu0YzsvpE1SOIeGxPIjOtK4qrDZU/uTD5VMjWmsCbPPUw+8VKck+tB
 Eb0GsFH0JztO7FDXGDGa0LRJcG4UOIF67coqOMb0NnUoJ/3cGSB3uNAfvTWVPgo1jvkJR5NllTd
 Cq2axme2qcYzZEPABNaR8qgzVs5geJMXW4MmLxr2j6b2kYkxnO+dfnZGc
X-Gm-Gg: ASbGnct2VI3/NNkHNuvNDpeDoMwmpeKwGjuBK7J3zS02yQiK7d/A9vpc1xa3jGoPD7h
 QDm6jBPHuaAZLgjofsh9FoHDD0tfdVcrbUWOB9dSIGZscJbb/i1KYN4p4Q1JB7ZgoUISi99Rg9U
 FSOCJkyPDZvqNwhNe7DO135JRsiOlgxjxpEKHr9GykCIjBSfVX0/J4629i294sPiOdfMMfraGQu
 O6SadShoDDsAfr/yXIKW5d8GeRyYWGIDj476/SBDA4O8s1wkp0KY7hBpg+Rm0AbFNnfMHtklL0f
 OVUOioP33CfDzQ+BtXuf3GdCyaF64eXARaAoS5ipckSQcQCuO+okvduHdWphVmxFYzw=
X-Received: by 2002:a05:620a:bc2:b0:89a:2f2e:2075 with SMTP id
 af79cd13be357-8ab9ba6ff9emr1717981485a.90.1762196657716; 
 Mon, 03 Nov 2025 11:04:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGitftkWJiZigmc6U7DMn/K57WxUX7eIK6ZWJ++zYNnTkD437TduS3fFXyV4ZubWtvx2VJ2bA==
X-Received: by 2002:a05:620a:bc2:b0:89a:2f2e:2075 with SMTP id
 af79cd13be357-8ab9ba6ff9emr1717975585a.90.1762196657243; 
 Mon, 03 Nov 2025 11:04:17 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f51e2076sm42883185a.12.2025.11.03.11.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 11:04:16 -0800 (PST)
Date: Mon, 3 Nov 2025 14:04:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH v4 1/8] migration: Flush migration channel after sending
 data of CMD_PACKAGED
Message-ID: <aQj8r_irRaZU2sQm@x1.local>
References: <20251103183301.3840862-1-jmarcin@redhat.com>
 <20251103183301.3840862-2-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103183301.3840862-2-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 03, 2025 at 07:32:50PM +0100, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> If the length of the data sent after CMD_PACKAGED is just right, and
> there is not much data to send afterward, it is possible part of the
> CMD_PACKAGED payload will get left behind in the sending buffer. This
> causes the destination side to hang while it tries to load the whole
> package and initiate postcopy.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


