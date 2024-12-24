Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AE9E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 17:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ8mP-0007UL-MS; Tue, 24 Dec 2024 12:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ8mK-0007U5-9F
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 12:33:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ8mI-0002pk-5K
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 12:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735061584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JOamrDeAvsJy4m270gwCwzlchvCz/7FjuiB24NY3+Lg=;
 b=BN30n5/a5f64LcpTybRfJaYWz5kEZAdpe0FH9kPZauOZVaelYER5rjLyKvf5Rib3VQMrug
 13ApCXvct5ZTLDBZSinKzZiZpAwQC8XPl0sqTVol47IM83y8VEXTR65SLoEx7E/Up5/BMV
 k29OhAVEV3Rba1JHVGpNA3NsAskUPAA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-U5u-L--2OlCDbFU9VLfLgA-1; Tue, 24 Dec 2024 12:33:01 -0500
X-MC-Unique: U5u-L--2OlCDbFU9VLfLgA-1
X-Mimecast-MFC-AGG-ID: U5u-L--2OlCDbFU9VLfLgA
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8e6046f0fso96626706d6.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 09:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735061581; x=1735666381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOamrDeAvsJy4m270gwCwzlchvCz/7FjuiB24NY3+Lg=;
 b=SxVIyok07qzEDfr7tOTboozcSeoa8I90m2amYYI2Ef62GsY3krpg8Q9Pr/9419N5gH
 GYncAYD/fJ9UnLclYfkgoN+CJSGEBlurcq3tC6JgPsPaMQO2nawSPIgB3Ad052F2YgIf
 jLibkKqSBFskA91MfCdqxtd642+r63elnGR1G37ZZJscvaqaTPPDIlKuVZTe7tANp7EL
 62HQ/tsy1Yyh38zaUBhfnoe7RXS54U47r7NAHs46UQ6dTJZNkDgfho80zJazQFDGXYVY
 xoo2D64TIIP8ORHHo6ftPedlIFy/790P+Ru4pHn22Sgx6RwQs1AQy9BGlEQQelkNFmhA
 0CPA==
X-Gm-Message-State: AOJu0YwDjq7EZiQZR+OCHQdHvEVXkqb/Quzaq/Vvg2/xTYdz2mRouLJ/
 6Bik+3Ufr05VdcNmFkz0dPKxl96lZeBihkH4d+z3qx9FEwYb+DGYZAkJgkbNt8/4o+tRIxCk0jC
 8n4tnwkinLpwUHK+9OCT91Quc9OFCujWFENK8N6NbFl1P4sh/wm/g
X-Gm-Gg: ASbGncvrg3irtcU1TAPK9wtnXkYZr6JeVjWIq/RErEC2dEXlHuEaRu4emGgUecSqHEh
 h1G6OsXeZHD0nEJb1ilOwB0X9nhsXEcQfgq/H1vZETkZjF/h94sdOd5yhXZGNdM35SFxEhlkB80
 GQyDdh5ffljLGtb1+V1tHDyInL2arx3PRtyV0Co4VHuYje3kDx/Rhc1EdpxGwaEfM0GLBEGgt06
 3TgjIzVGpPyfea3WRyggYlBopF06rP1ve/fVK7DyvC6P/q7l9568x7q6hD0BnlwyjSR3EXXKPHx
 0YsSUT1Tj0zKq2u3Og==
X-Received: by 2002:a05:6214:3001:b0:6d8:d79c:1cb2 with SMTP id
 6a1803df08f44-6dd2334b2e5mr302481936d6.21.1735061581017; 
 Tue, 24 Dec 2024 09:33:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3vwcg5AJXfolNYjfis4rv9TvRfe9XwgyaM3XRb0XOil3Ygb6oPA7kwYpTJ0vDeC3DJQVKHg==
X-Received: by 2002:a05:6214:3001:b0:6d8:d79c:1cb2 with SMTP id
 6a1803df08f44-6dd2334b2e5mr302481686d6.21.1735061580760; 
 Tue, 24 Dec 2024 09:33:00 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd1813900bsm54673486d6.67.2024.12.24.09.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 09:32:59 -0800 (PST)
Date: Tue, 24 Dec 2024 12:32:57 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 07/23] physmem: preserve ram blocks for cpr
Message-ID: <Z2rwSTt3nWXQRvL_@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-8-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735057028-308595-8-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Dec 24, 2024 at 08:16:52AM -0800, Steve Sistare wrote:
> Save the memfd for ramblocks in CPR state, along with a name that
> uniquely identifies it.  The block's idstr is not yet set, so it
> cannot be used for this purpose.  Find the saved memfd in new QEMU when
> creating a block.  If size of a resizable block is larger in new QEMU,
> extend it via the file_ram_alloc truncate parameter, and the extra space
> will be usable after a guest reset.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


