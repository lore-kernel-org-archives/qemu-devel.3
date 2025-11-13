Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCE0CD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 14:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJXsa-0007Yc-LK; Thu, 13 Nov 2025 09:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJXoF-0003WG-1J
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 08:56:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJXoD-0003iy-6N
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 08:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763042179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tevzkRL/9a3vRB+pKx5iZthPM6IboREJidBAz+AAN7Q=;
 b=H5V/V/x66F7zmnA1rCDv7lKs0ZMpb8I7dnGqU402TIdGs0iPE7RGQTflNasJJCJvFUKXC1
 qzLlmYjiBKA30b0QkO9g6/sAkkImR5kDarPH/XoCYdbIhi5wR6SsBfuMd5c+AW24t2+gkm
 3PRhCIuipW9xjrrHCTrxvJUiV47kuto=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-3ZwFlbKBPZqx24NJ5-vFEw-1; Thu,
 13 Nov 2025 08:56:16 -0500
X-MC-Unique: 3ZwFlbKBPZqx24NJ5-vFEw-1
X-Mimecast-MFC-AGG-ID: 3ZwFlbKBPZqx24NJ5-vFEw_1763042175
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AA7418002C7; Thu, 13 Nov 2025 13:56:15 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.22])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64E3C30001B5; Thu, 13 Nov 2025 13:56:12 +0000 (UTC)
Date: Thu, 13 Nov 2025 07:56:10 -0600
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, philmd@linaro.org
Subject: Re: [PATCH v3] tests/unit: add unit test for qemu_hexdump()
Message-ID: <tokibkrjha4hqa6pwgviht3nwhryw4gnmobklabl2myb2wfk3x@bm6kam2fydl4>
References: <20251113064935.342018-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113064935.342018-1-vsementsov@yandex-team.ru>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Nov 13, 2025 at 09:49:35AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Test, that fix in previous commit make sense.

"previous commit" is ambiguous, when this patch is not part of a
larger series. Maybe use the term "recent commit" and call out its
title and/or commit hash?

> +++ b/tests/unit/test-cutils.c
> @@ -3626,6 +3626,44 @@ static void test_si_prefix(void)
>      g_assert_cmpstr(si_prefix(18), ==, "E");
>  }
>  
> +static void test_qemu_hexdump_alignment(void)
> +{
> +    /*
> +     * Test that ASCII part is properly aligned for incomplete lines.
> +     * This test catches the bug that was fixed in previous commit
> +     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".

Ah - that's the line I was expecting in the commit message; and I
found commit 20aa05ed from there.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


