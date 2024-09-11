Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D891EE57CE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 18:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soSL2-0007Cu-EV; Wed, 11 Sep 2024 14:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1soSL0-0007Am-06
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 14:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1soSKy-0003GL-2v
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 14:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726080306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KlZJrnTUQHtJz7LkJ7OovI/PzRPTj056Fhwk0ZhTTe4=;
 b=TxqnfeO8/BYnj1OxqkFLbYtucoVeDX3nGrOGN9T564H2JLI/ASU20dScRfIkHk/YI5Pgzz
 PWPr2gMgawoowreXEM4SbvuB8p06Ky7BwMI6IId40QCBmI07ttTwDXYppPgv5y7Mzk54L6
 IqmN3YFqtp4Zf1l3+dWlwV1hEM+sH9g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-uDaYs1vKMGis_Dr2tfeZYQ-1; Wed, 11 Sep 2024 14:43:24 -0400
X-MC-Unique: uDaYs1vKMGis_Dr2tfeZYQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a9b86db6cdso27832385a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 11:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726080204; x=1726685004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlZJrnTUQHtJz7LkJ7OovI/PzRPTj056Fhwk0ZhTTe4=;
 b=LA0yDQ6Gb5HJdtxQo/luLlUuqtFS8Uh+APz4vVDBTsZdrmEbqf6Xz/eKpIvjOL3Y1G
 7AnwHLLNsmL4/OC/QZpYsFgpuHAG8ffweGACzKg+ooajT5JvFkYnLCpl0XW3JRR3kN8Z
 s9mqr//lRAJjRRsYT7Wk1o+Arorzvcjf0wcs6g4Fzr7AH+Bngl+DHY+VrLkBGEgw/sfD
 F1eQ/dgGWdAu2Yg8G+Ru9I7GqWmpLenk8rLkL5fCk8dj6F3RIt+scWokjZyvkj6kJo1w
 NWBQltdIyCLJPkBjjOgREiSbCE4GqlupcEFKrS2sPiK6JRUaqORr3p2+QbBjyz66+d6Y
 8xaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEQvcqP4WjavNR/Uv0r7pTc0tUXEbu8kt2g9h7y/ptZrH38jnIRPb9XT20hDT8lfPihJKUJOMGgI4p@nongnu.org
X-Gm-Message-State: AOJu0Yxw4bJRvY2pMp/KT28hPBjbimyO4FUuIr7F38AXdXDoZypzSSdR
 aoQTkJFHnsaI2SoQF1PpbkxsRSfE9JHYOSMSaZBh23o/tFLebZialjcuz/MNR2FGpu6lTPwj7AK
 RHdbDntArICGuzfHOaOei4Aq/Xgmxo9Lar88bviaKEl+4z9LjhT7G
X-Received: by 2002:a05:620a:2485:b0:7a9:c8a1:5d94 with SMTP id
 af79cd13be357-7a9e5f03c86mr54688085a.19.1726080204270; 
 Wed, 11 Sep 2024 11:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1IwGEGxKC6UEKeDmr3DEWgJahrKKLdfrHynj8gmVGfrRNkbI6V/3295L+2THGe1lQsvcZiw==
X-Received: by 2002:a05:620a:2485:b0:7a9:c8a1:5d94 with SMTP id
 af79cd13be357-7a9e5f03c86mr54684685a.19.1726080203861; 
 Wed, 11 Sep 2024 11:43:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7968ed5sm451972385a.42.2024.09.11.11.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 11:43:23 -0700 (PDT)
Date: Wed, 11 Sep 2024 14:43:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] migration/multifd: Fix loop conditions in
 multifd_zstd_send_prepare and multifd_zstd_recv
Message-ID: <ZuHkyBeEqdsfOu1-@x1n>
References: <20240910054138.1458555-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240910054138.1458555-1-sw@weilnetz.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Sep 10, 2024 at 07:41:38AM +0200, Stefan Weil wrote:
> GitHub's CodeQL reports four critical errors which are fixed by this commit:
> 
>     Unsigned difference expression compared to zero
> 
> An expression (u - v > 0) with unsigned values u, v is only false if u == v,
> so all changed expressions did not work as expected.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> 
> I don't know what effect the errors will have.
> Please check whether the fix should be backported to existing versions of QEMU.
> 
> And I think that it might be a good idea to add the security check to
> https://github.com/qemu/qemu, too. The critical errors here and in net/colo-compare.c
> were not reported by other static code analyzers as far as I know.
> Paolo, if desired, I can send a patch for CodeQL.

I hope Paolo can see these lines.

Patch queued, thanks.

-- 
Peter Xu


