Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B72EFCE33
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxr1y-0007HK-Bg; Wed, 04 Mar 2026 13:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxr1v-0007H7-SK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:33:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxr1t-00014V-Uz
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772649184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RzKWKJLbQY1OqrbeixPU7SVnQdgyDia5ch0sqGv2KQg=;
 b=X5rtCpntwhMi16oelGpWc6HssCM8h5WY7ISnLVRO4HFRu9HlSe7pevN6XJHNI9ywjqBQoA
 1b/0iV3lgyA6D/rJY1h8FrnSIjrzYGlUv3LHK/WawMO0GGpPNpx9QGqUHZW2NGdnVSOSRz
 w/bCnwr7t5Axzs/FN3jYSHsO7cUbuZs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-kSXdBBXCOSKpq_9pR45WZQ-1; Wed, 04 Mar 2026 13:33:03 -0500
X-MC-Unique: kSXdBBXCOSKpq_9pR45WZQ-1
X-Mimecast-MFC-AGG-ID: kSXdBBXCOSKpq_9pR45WZQ_1772649182
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cb3b0d938dso4996764685a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 10:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772649182; x=1773253982; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RzKWKJLbQY1OqrbeixPU7SVnQdgyDia5ch0sqGv2KQg=;
 b=Q5gqgFvbBJWsLx0+cG1nS6d3zZ7WSb43yFt4p9tsWlknHH9l2OEySMPfrFouE8ZFl3
 HozXp5bdMFMjnMFtKQjI7HBO7lndmXNrysRD7v5A0SKwFZNhVV6jOhOn8TqzlpVzaXn4
 0IIiCRHRstdTL4kjfAJ6qGFwaTaftmKhyoXuIiUvxGPWkAblL7S1WhF0YjEgOg0pv1/g
 IsVKbzz6xq5dHC2SahNUGAqTjgFiFTGX2w3P0NbmVmZlOHXWpKU7LoTUnQ+OmaxNHavM
 UAKlXYMEVnTT2xVxSeHH8cwstjxgZYz3wvv00hOjimIXv23rvquORvhRhvgyfACUr2Pf
 lKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772649182; x=1773253982;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RzKWKJLbQY1OqrbeixPU7SVnQdgyDia5ch0sqGv2KQg=;
 b=wKyLm2b1MLMJOHZm4JjwmOrhQPg8LdV7UFSW/7nvQvv6QYEAscnMPEVS4JvTFmJp4V
 lWh6W1ZR/kuGLz3gePmmqSnPykwVXo8yXNWz2NEryXstXMzPsqD1jMzgSI5KMgtk5G5b
 52D+QxLv9ZKxbL9EFuHZPYQ7ZoF8incmYaSBHSXMhJLl/h7zCR51WQRNxGL0F+gJ/Ppc
 BjrqgUsoxgB+WNfBQgUnklx6kHjPtNjeD4urXGrvAK+63AnuDECuNN29PyJReQose8X0
 tgizqGoe02XURTIWszGlZSnVFwOxywksh9FyYJmfXDR4OheHu7kyrl3kq7t2e6Q19Pvm
 hFfw==
X-Gm-Message-State: AOJu0YzQCLNhOseF5BQfC9qY12xbr/jypWVRB/xm6KpyTCYH4gyyNC72
 9gjqaVbm/0VJn/KVC+3mDMhehoB7sE475WLJiiFzhBhjF9QdlCIb5+TQVWYsj3d+G51kgsDe6wY
 DnnY5fRF7Go2lCZPqWuavVKLq6PYR4yzpsIZwjkMif9XlMYId29hzBky3
X-Gm-Gg: ATEYQzwOp8VsnsiNdcbu3tNzCZtISLDLx4exymzxH/d0IRsJlLkJkUMVQ9A+DgAqxlM
 MTKts6VDKWj7qNLmQSAK3IoISpJpMxlRNEfEdIPrA4MKtht4naToAxg4VvNZPmGVF3nAXTVANsJ
 mvtuh/ZX/4qm33YM8r5tkZfOICKALq+oIiCvMP4XvSnbEmG4fupqXxL1iAnXN4YBql3Oi/jxeEq
 Jr1VmOV38p91kRdFHzvfHKhXcHEw2RiMUJrR4ZAKzM7fIpCR9OjFqiqZriql6ulyCE7WF41GfiW
 brwwkKeaAoo9jP03g30GV/Qjd6Nc+22yZjtIISLPgxjoLlsOgmtUIFNS5R8INiC1rbATfqxupb4
 y9zwH4FB9HMJrAA==
X-Received: by 2002:a05:620a:198a:b0:8cb:3f4c:eead with SMTP id
 af79cd13be357-8cd5af9f377mr335945585a.56.1772649182431; 
 Wed, 04 Mar 2026 10:33:02 -0800 (PST)
X-Received: by 2002:a05:620a:198a:b0:8cb:3f4c:eead with SMTP id
 af79cd13be357-8cd5af9f377mr335941285a.56.1772649181894; 
 Wed, 04 Mar 2026 10:33:01 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899ff659b75sm72511496d6.34.2026.03.04.10.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 10:33:01 -0800 (PST)
Date: Wed, 4 Mar 2026 13:32:50 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH 1/7] stubs: Merge physmem.c within ram-block.c
Message-ID: <aah60nXJnLeTHKrP@x1.local>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226220226.20164-2-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

On Thu, Feb 26, 2026 at 11:02:19PM +0100, Philippe Mathieu-Daudé wrote:
> physmem.c defines 2 stubs which are related to ram-block:
> qemu_ram_block_from_host() and qemu_ram_get_fd().
> Move them with the other ram-block stubs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


