Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD645D3E77D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 22:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTSKW-0002UC-Rp; Wed, 10 Dec 2025 17:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTSKU-0002Tn-IW
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 17:06:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTSKT-0000R2-0r
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 17:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765404395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nz/4OKzPfvvQUCC+OEaMcJbOw23TE9OoCV+QSkY8dx4=;
 b=ZgY7A/ASEaKbOeduoe63dchJaL/7pceFizkn/Tu/tMe8/RcvQrabRofvB72QjFXPStzl5I
 Zrnrg3OlC3a48QsvC83OI2N4cdv9pJHyoJH/IrXOq1sCtN/7OyAQ+PWqNToCFIfRC8I9ui
 3CezFtOtIKf/6893dg3AuzN8nlUGq9c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-YvCvs1fGN6ONYdEeEOLl6w-1; Wed, 10 Dec 2025 17:06:33 -0500
X-MC-Unique: YvCvs1fGN6ONYdEeEOLl6w-1
X-Mimecast-MFC-AGG-ID: YvCvs1fGN6ONYdEeEOLl6w_1765404393
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8ba026720eeso71486985a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 14:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765404393; x=1766009193; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nz/4OKzPfvvQUCC+OEaMcJbOw23TE9OoCV+QSkY8dx4=;
 b=LZsZCM7CbwmW5PpfShUykaMfTghu+0c6n7WY3agMpYz87SmaRKeTPfaKOiM12NTi5l
 5Uy35gG4aDjl8ndBo0qdTeOJDDRULWdl1cVzeb8ZlGZU0RMefkZ4zLvM/jIGO/XFEL1Y
 /uCahL5JL4ad5cS/xf4o1RF3XnX5bwfcYdLzGa/0a+xzQjRCb01QqvUPo8Ux8Tt1mbM7
 LxILMRYkdAHAAg2R9oPbudhNKIoCNEU+TBJ+lvxBzkJFBze69DQGv/bipi0Tjjcs7+ZB
 y2dfKvqBaavI1A0zx8HSq0F0+wCCfdw5fJWZ2Sd5hVX6dcham7YiVvgJdfLVJMs6sVo+
 nF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765404393; x=1766009193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nz/4OKzPfvvQUCC+OEaMcJbOw23TE9OoCV+QSkY8dx4=;
 b=c2IzX8EWkA+9ruEtXLapAUHKTjJRwIFH9D0mrgO6/jNVPyp06MrVWKt9mkuIsR3lrt
 tQDBaYEzYfe0FwfpeHqV9+c9aDBkTd6brNEpbGpzYyZykLvNUtDluma7Uim+ywEwwYLu
 ZGf5jEVMGbrfZCtWxjxyRljz1wfhqz/7DHq5KkEXJcJurQ5PexhK4+YOXN3U6EkWV7KK
 8hHRF6ZHgtplg3kU1UWC5Pqbo/MqUUAAKnKaqofp8GrQ6onVseaZjhUTiQnhBK4B6+vZ
 cxhEwN/69tRjeEWE+xyv8MGIf5vfggo7dJvhFaLhRGs3ZN3m1/Ymn65vpikogpwLsvAd
 1dmQ==
X-Gm-Message-State: AOJu0YzTSJUe64nW1TKyWs9JKKGqCCxvPLIfm50WCaOhjdZIrdoL6wx/
 NZ7f+vEIwxD6u+K0vsFn2uo2vpYmJDJxk5I+8KpTmLSzqp8ovavUWxGa1S+4NzKATZcpjQ1Th8P
 PbcI0Pg6TH4Ww3QqgFwoDpH25yprBt4u2DDeTFkMlsuJwLp8PxxM3vjjq
X-Gm-Gg: ASbGncuZT4jpW09ZAFcX2D98zGC6o+RMdLvGLbpQxLB/pJNUZjETBFN91KogyOpGwGs
 bv8NC7eYZscpemQiLPm+wvEns//CCSt7/nMD1q2W07BajUWzDYV6q6qY+QtYWLMhGMdAbPCpaYF
 CXLHUY8tevIgmpLze2HSwq0EHcxkc8xRrjHKcOTrFcf7x/DxvK6OtVoMdTlgIcBu1TU+att9Xdz
 fvgRcBU5fPa1FRyQ26b1PKIZ/hkfMkVHPcDJkfkeuAo3Q45QD5yyiGUpuRLeKKroiqlXZRAzbD7
 YCA3tfRB34y6WZPwZP6YxhFTCvP1X46Q2BGDeWwCDFF7XnnmoH6r0GbHfW4ClFOgfWGvSZ4cbdG
 cvoo=
X-Received: by 2002:a05:620a:2684:b0:84d:c10c:e42b with SMTP id
 af79cd13be357-8ba39a3cdadmr662641485a.17.1765404393130; 
 Wed, 10 Dec 2025 14:06:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzOiq9LJHKXCn6mmvV0hm2uqW29hZIyJDBY5mjMR7BwSfkuiSAun1NWtvQxJA2pZmflb4sSA==
X-Received: by 2002:a05:620a:2684:b0:84d:c10c:e42b with SMTP id
 af79cd13be357-8ba39a3cdadmr662635685a.17.1765404392588; 
 Wed, 10 Dec 2025 14:06:32 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8bab5d3e141sm53586685a.38.2025.12.10.14.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 14:06:32 -0800 (PST)
Date: Wed, 10 Dec 2025 17:06:30 -0500
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 08/13] migration: Thread-ify precopy vmstate load process
Message-ID: <aTnu5vaw3Oqlzi5U@x1.local>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20251022192612.2737648-9-peterx@redhat.com>
 <52209f0b-47c3-4a61-8eeb-a1a826f4c2e9@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52209f0b-47c3-4a61-8eeb-a1a826f4c2e9@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Nov 04, 2025 at 02:40:53AM +0000, Zhijian Li (Fujitsu) wrote:
> Both COLO and RDMA changes look good to me
> 
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com> # COLO and RDMA
> 
> And with an addition fixes[1] for COLO, the whole patchset:
> 
> Tested-by: Li Zhijian <lizhijian@fujitsu.com> # COLO and RDMA
> 
> [1] https://lore.kernel.org/qemu-devel/20251104013606.1937764-1-lizhijian@fujitsu.com/

This is helpful, thanks a lot Zhijian.

-- 
Peter Xu


