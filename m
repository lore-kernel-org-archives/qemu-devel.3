Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D96C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 17:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJV9-0004DM-4J; Tue, 23 Jul 2024 13:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sWJV7-0004Cc-63
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sWJV5-0004qc-7L
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721756432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=un9vtkRR1w0credSqvO8vieYnutQp1fSb58h+yfHqd0=;
 b=Fyzm5ZtArducwZzcfSPQOme6Jz2sUDRlafBDKVyl50kbgVKqRzQbXSqtfg8rKsS7kvSYZz
 /HveOfno0YT3lj6wwx9U89eMVg3Vnzz/LVEkBb/Vqmtq2GimvFJFM2VIrvGNDd0XHTdymn
 bUpxQ0it2IXKrhjyJRXl+87mk6/UUOI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-cMSljiiUPdeEgzufBbthrQ-1; Tue, 23 Jul 2024 13:40:30 -0400
X-MC-Unique: cMSljiiUPdeEgzufBbthrQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b797b6b4aeso18082606d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 10:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721756430; x=1722361230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=un9vtkRR1w0credSqvO8vieYnutQp1fSb58h+yfHqd0=;
 b=wLC1nn8x1nbpbfNveISYMit1K2ioCkQ4jMpvIkhOOiVpIXeoxezA3ucrVcipPwOlve
 ayYGnGDlJJqcG1ZUpn8+5tm2r/3k2m+54JhSjobSaGPc9U3u9ap9NqCj6ke/g+dPlXAA
 DqPqHs1RgAjW6NMJ5khhopbuK8HDZ58ugStN3v1vtcJRATXk+tHUpKkydz1+U07ZGkv/
 pkAJu20/VVac+e/mW5zNlwZbWnE0nJK/H6R8cv5i4py4eKXzT9PskeGBHEwZwQhkcXaB
 59b/40SO+rASKQmpRsSyyNs8NRy7i2vVSpheZ8dNY0v0Xs21sH/MacrUMJEOUadWv2K7
 5iNA==
X-Gm-Message-State: AOJu0YzM+IUoP7kjwd0+Ro5LNi1YDBmMzZgPZiddm1GCihmjNSN+EpMR
 sXWra2c5g/Dh+u/K+4D20oJxkjmKLq3AJVe0EGdR/C90s70RrFcaSitsFYR9QHhbYWSwIl1uWUW
 /PX6ZpGok5EgAQ5IPZF2UgKf6N8cKD8QLwMfii8YPPL0jk1j6TIfX
X-Received: by 2002:a05:620a:24c8:b0:79e:fbbd:6631 with SMTP id
 af79cd13be357-7a1a139d31amr811241485a.5.1721756430001; 
 Tue, 23 Jul 2024 10:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSEqtSUb6ZxoPkZW9cs6N5LXIedIKlJhle9hz6IWzE/tZFYVVUN5yJRZFzzlzlrU4G2qG36g==
X-Received: by 2002:a05:620a:24c8:b0:79e:fbbd:6631 with SMTP id
 af79cd13be357-7a1a139d31amr811239985a.5.1721756429569; 
 Tue, 23 Jul 2024 10:40:29 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a19907b1dbsm500382485a.121.2024.07.23.10.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 10:40:29 -0700 (PDT)
Date: Tue, 23 Jul 2024 13:40:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] system/physmem: Where we assume we have a RAM MR, assert
 it
Message-ID: <Zp_rCvb0CokdiscZ@x1n>
References: <20240723170513.1676453-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240723170513.1676453-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 23, 2024 at 06:05:13PM +0100, Peter Maydell wrote:
> In the functions invalidate_and_set_dirty() and
> cpu_physical_memory_snapshot_and_clear_dirty(), we assume that we
> are dealing with RAM memory regions. In this case we know that
> memory_region_get_ram_addr() will succeed. Assert this before we
> use the returned ram_addr_t in arithmetic.
> 
> This makes Coverity happier about these functions: it otherwise
> complains that we might have an arithmetic overflow that stems
> from the possible -1 return from memory_region_get_ram_addr().
> 
> Resolves: Coverity CID 1547629, 1547715
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


