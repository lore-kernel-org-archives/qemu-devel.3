Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AF3FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHGDx-0003TH-S9; Mon, 27 Apr 2026 03:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wHGDo-0003MH-Fo
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 03:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wHGDm-0007IT-Tp
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 03:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777274252;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nRkUXjbiTb5o8nDyZgLsG3YWoWxyCvPbjoEUBjoTaqo=;
 b=M4HuhbLMIpKupkX07U/VGEmBJDORkigC8MmhH1csru+0YZiJm10Xzy5yk22rjSF4juSf+/
 gcjA+bFFTR4jWipAsmjNF0IAtphimtjIrb8+Ba+ucuu5boGtNptXNJfBnUthHmHRX0a8mP
 SYKiFz7QojIyL9vwq+imksY5+1QgpKk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-Euc5T6_aME-0QQed-lRu4A-1; Mon, 27 Apr 2026 03:17:30 -0400
X-MC-Unique: Euc5T6_aME-0QQed-lRu4A-1
X-Mimecast-MFC-AGG-ID: Euc5T6_aME-0QQed-lRu4A_1777274250
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ac566014e0so39789406d6.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 00:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777274250; x=1777879050; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nRkUXjbiTb5o8nDyZgLsG3YWoWxyCvPbjoEUBjoTaqo=;
 b=B8UulGjXU3To/jU7r84xCGe3sJMKvgf0NjFpiU0UToiLLVMb0fMu5cq7T9yqzTZ9HV
 R8JoBMhX9Q1dOQEBk8ddoznIcBYlvmoTYBrgeWwnVHOZjAFYbT2JUVziogDlXozP7zZS
 5eSV/0WfCw0OKJKPoFY/zNUIUth9PEXPv9eCAopcK4OwkDhxvOaM/bhCeiIot55yuSk8
 PV70gw1WJXo4fb53b86k9wFvbHBkyi6nKslIfx01J0SpoorQjOudIQkkjWeyYy3jhlqD
 IH8M+GlBDrtgRqldq7b3nubn6BnkSqRGG07CVSl8roz5VCqm8tuxXfqp3SVf9cV8TD6+
 fdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777274250; x=1777879050;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nRkUXjbiTb5o8nDyZgLsG3YWoWxyCvPbjoEUBjoTaqo=;
 b=nR4DJ76NNwBqFnNiDZeeMNVaIa96BKt+Rn5L802YYtc6CEjTHBvIdXQS2BLSSyhUkP
 KENqnQJigEWMnROo/bKigcY8skYmoRq4QhzPfL82Le0UvauJGLOnx3v8jLtKiEsBmvix
 H4BqgGRTpM/BXqUB/l5AtRnbTHrHKKn1UGrRoFAjslKdh8P+niOyr0LbxG8VMlXV0XEn
 sKC9G2BspRujy67J2TZeSNUg71N/IuPzGBGcbSC/IUdlsxgyJ67HjlPi8/qTiK9akolE
 RM+n0ky7x61aZdrqGVYFpBTSxdESstg79IwVYhSLDGYptJA/Qg2pZPv2ZxX/bx8D8X3E
 I8rg==
X-Gm-Message-State: AOJu0YxWQTVlsYBLKRte2YDjWiB1yB+D9DVl/u+3jAeiC6RR11exfyv2
 AW9ufziS9+Luu8DfcuDsgBToQOrGgWHMCFN9ZtfON0ZxU9C3iY2kKtPv/NRd4T/NIxSN/iqsgwC
 rrUH5Bi+d5gDKJO74faguNSgOebePvP9bsMKLV2mkku59OAXf0azh7D8t
X-Gm-Gg: AeBDies7jTO/c3igBPLPsq/V5s2tdBDYbrL+1toQvDc8OKsowE/4PxvIBs16+ZkNcss
 fjpA0GlmQ4UuipH1H23Lo9amXwjhkwJBP2NrNoAt9923ghFzuKhZJLYU4mdWSrEdGPi/CXXA417
 XtdpstQZCSpa9qnjxS4jePssu/3T8ejj/3nLdoZo3++pW/YfPgGa766mOA2G221FZc4pd3QSzRT
 ZvtYFGI52Eb5fl47o+Ulc9gBTpQ4FFkbJsgi5f/Erodom+q4zIlgWNg8TrFqkjdIAWz9ynJzAcB
 9KkZgB3eud84eC8XaN4L3BVr0aLTrpM5JXwRMfaHqFhoC9rm/jtMS9OVylTC0xMC1iLs7F/j0gl
 RRkQmtvGLPamr4qSJeb5K22jmV/aNxMo=
X-Received: by 2002:a05:6214:33c3:b0:8ac:b4d5:50db with SMTP id
 6a1803df08f44-8b02818ec3fmr627664986d6.28.1777274250212; 
 Mon, 27 Apr 2026 00:17:30 -0700 (PDT)
X-Received: by 2002:a05:6214:33c3:b0:8ac:b4d5:50db with SMTP id
 6a1803df08f44-8b02818ec3fmr627664656d6.28.1777274249811; 
 Mon, 27 Apr 2026 00:17:29 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae97d89sm256466316d6.42.2026.04.27.00.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 00:17:29 -0700 (PDT)
Date: Mon, 27 Apr 2026 08:17:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Samuel Zhang <guoqing.zhang@amd.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 lizhijian@fujitsu.com, eblake@redhat.com, armbru@redhat.com,
 Emily.Deng@amd.com, Victor.Zhao@amd.com, PengJu.Zhou@amd.com,
 Qing.Ma@amd.com
Subject: Re: [PATCH v6] migration/rdma: add x-rdma-chunk-size parameter
Message-ID: <ae8NhTr69D7Wzejz@redhat.com>
References: <20260427031401.3895523-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427031401.3895523-1-guoqing.zhang@amd.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 27, 2026 at 11:14:01AM +0800, Samuel Zhang wrote:
> The default 1MB RDMA chunk size causes slow live migration because
> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
> 1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.
> 
> Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
> faster migration.
> Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
> 
> Performance with RDMA live migration of 8GB RAM VM:
> 
> | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
> |-----------------------|----------|-------------------|
> | 1M (default)          | 37.915   |  1,007            |
> | 32M                   | 17.880   |  2,260            |
> | 1024M                 |  4.368   | 17,529            |

What is the downside of setting a larger chunk size ?

IOW, why should we keep 1M as the default when it gives
such terrible relative performance ?  Why not make 1G
be the default instead of creating this flag and requiring
people to know about setting it ?


