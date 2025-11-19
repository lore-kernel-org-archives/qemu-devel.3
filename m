Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB1ACF58C4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 18:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLmch-00038o-Fw; Wed, 19 Nov 2025 13:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLmcf-000387-P0
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:09:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLmce-0002vU-Ej
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763575779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iWKuGlFXZQJhDckFQcgt5gxApYJTrA/9Towipm9l4OQ=;
 b=Mk4COYZWJwqxkbCD7w/rJf+B6D1RrfFpCZOdJFtdbUo0HpMjk0AMJp0jwLW07WVi+Z9Hvb
 4u/DA8x0yutdqk5u0/1ddEWpVYWCvkiMzuToNQ31uNZ3twSXk14qTXn7GI3ajq0ef3jjZH
 g9bQttHYHsjLwQQEFwRz/RUXh1Hg1ww=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-MNagh8edPTqUSsdymy5_oA-1; Wed, 19 Nov 2025 13:09:38 -0500
X-MC-Unique: MNagh8edPTqUSsdymy5_oA-1
X-Mimecast-MFC-AGG-ID: MNagh8edPTqUSsdymy5_oA_1763575778
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-882380beb27so537036d6.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 10:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763575778; x=1764180578; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iWKuGlFXZQJhDckFQcgt5gxApYJTrA/9Towipm9l4OQ=;
 b=Yj/MdEhiF7jyy6z7NRodWUxfTA9rmYFJXcFBKMuUbpaH8X4weaSHdE6OPjexhpqkZs
 U0t8JqxgTBQHy+PDTTJuKE40LE24ia9tKZllMjcqUDrQSbic34NLsFbloz3zpwoZzxoZ
 swXtVZ/t0KdwZIlGvKw27SRoeOosDZAROwOs1Q93Yih2ao6qB+mLeEowpvAaHls72Ytq
 Bvsa0SEY7rWm+0KI+Ona7YRQF83ELYvT9EJ75qR5l6TFJAwyewS/Eb279dqGubnNqUWz
 Iw5fAxy/n7MajZ6/daPbG4EFQoI1DiSFRrTZiroQkbMp7JKX68z+fBvBE22tII6UJA0T
 kAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763575778; x=1764180578;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iWKuGlFXZQJhDckFQcgt5gxApYJTrA/9Towipm9l4OQ=;
 b=F4knWU6YcPj71/SvwJKXtUaChVx7avSNP6peXbiqMEQEgrBP2o8BjypJFVxb1g1d8w
 zQYnqNb9lDU6uX78QqhiV7FoUNKdvsM4NA6LsRSs/nK3Ay11Nj3CEUIBHFsdetGNSfbY
 h/d2b8Sx34ndc9nF7uKi62vNPYWmpHGImemIdQ26efbzF4Kdfv/E9AsqgyYgERNI3dwJ
 aFvTEePsMu4QxHxxUpW5DsVhArLThSzJtGdbsXfE5ejMy9abVQJqb8JjIRSWc2rFh+4O
 Vh+zmpfWEwbcEUIhheX3wmgPo7eHchvyfzUiW0OLdaK+gIJ5sE7k4XkG6lhY17tH1KOT
 JJgg==
X-Gm-Message-State: AOJu0YxHVXUJeNUlgAOb/KC3QyuZZSZrWTI/8/PQuAJ9GmVQEtVMpb2C
 BG1psQRVYg75/xwDsDRIxDwEuMkpojevm8h0sc5Us7FsA+qBcDmAgq75Nb1R37daAW+63SDHs5T
 aOJQ4Xi8bBifojoRrrORVtCufzabZluSkumo7bwKD6Pm5QkdLWGXvFTEn
X-Gm-Gg: ASbGnct7tWeS/1WiUeQo+3fAtUxA8PY+PPQ1mRgWv38W8jyzOXjTQ02oHVdixDDbP0s
 wU9nf3c8LoQoHGzkMKsyWwb2+j5vB89SnRhqKALYCKhAuzvVLWkxtrQZgRNZNIQTRnhvTuUJxn4
 d9JO+VONbJQRbteQTT22iDtj/UrAc4aLoIFZsplWExAKEJHTHI0u0XkoslQ1xvQvFhLxZFiEUTa
 gV3AIXNKt6OBUv9hikdY45/IgqGA5GOYp+DOYcHTAVPewlmSyMT2gXH6Fz+JghVXZ1Z3gU8J33r
 Sxity03B88xYvOaqoXWDzq+j791uA2aYLaEbpWp7mhfAi/RvxB39cLsMZHdpj9BOCAgm7myUDON
 Wb/Y=
X-Received: by 2002:a05:6214:33c6:b0:87c:a4f:afd3 with SMTP id
 6a1803df08f44-8846e02d57bmr1889356d6.16.1763575778015; 
 Wed, 19 Nov 2025 10:09:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELSahBwRm5SxgULUmKqEQouDGBl9IAYstEeLqOk0A49a/xIWSs9mc1bJ81aMUBPzhLGlz0ig==
X-Received: by 2002:a05:6214:33c6:b0:87c:a4f:afd3 with SMTP id
 6a1803df08f44-8846e02d57bmr1888776d6.16.1763575777665; 
 Wed, 19 Nov 2025 10:09:37 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e445bd4sm265876d6.10.2025.11.19.10.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 10:09:37 -0800 (PST)
Date: Wed, 19 Nov 2025 13:09:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 alistair@alistair23.me, edgar.iglesias@gmail.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 berrange@redhat.com, farosas@suse.de, eblake@redhat.com,
 vsementsov@yandex-team.ru, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH 3/5] nbd/client-connection: Replace error_propagate() by
 assignment
Message-ID: <aR4H3-CQ-F8ZUN_Z@x1.local>
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119130855.105479-4-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Nov 19, 2025 at 02:08:53PM +0100, Markus Armbruster wrote:
> connect_thread_func() sets a variable to null, then error_propagate()s
> an Error * to it.  This is a roundabout way to assign the Error * to
> it, so replace it by just that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


