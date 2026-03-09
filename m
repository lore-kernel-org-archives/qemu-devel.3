Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B3CF41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzchq-0000u0-V2; Mon, 09 Mar 2026 11:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzchn-0000sn-69
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzchl-00055A-4t
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773070776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ftQkCj7dl0BHtVdnSc70G0vnRqt+zl2O9gw+jSpGoE4=;
 b=AhyRCAqzrRzDZHyOlQ/vKVnKgJ10x/fgSU5J8WoHcqqZ1vQtEEMBCt9wNfLep3ThCcmZ2H
 w+0AOi3r3XJtvXnnqvphdqSi7J8k/X5VtczoivrSA0KC9Jo9Ni3gsChyEszkYS/VkM4rnj
 TLsgnxNCbJA6Cy2ikNzAg9uWleQ2R+g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-Syzu7r-PNVuVbiOJ9b83sA-1; Mon, 09 Mar 2026 11:39:34 -0400
X-MC-Unique: Syzu7r-PNVuVbiOJ9b83sA-1
X-Mimecast-MFC-AGG-ID: Syzu7r-PNVuVbiOJ9b83sA_1773070774
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-899ef673d82so160461536d6.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773070774; x=1773675574; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ftQkCj7dl0BHtVdnSc70G0vnRqt+zl2O9gw+jSpGoE4=;
 b=a9F2wY0gJOaKI0vWsQc9e1GQzlB1OwRRWz6WmikFO8A+ciNb2TPV/sex9ZIiOMNj6j
 umsUHj0HActCs6nZznprMZQwLjd55lm2xw0Jg1YfwDafCpUvKzATXLjoQXG1M7Zt1J/p
 I1G/4O8AmTfk6zWoMy2/wEYsMtm7S8K+6MqALzUxvunTQ3xtedeJ+XBefoTzM/A9GSzp
 +UX2MCSe8+HuyDimnScHL7nLFwp38f7f3pI4kbaQ8nsTKQjBr4Y6/bW9ItL1F2euVO10
 Ef9mjkIJjsrwk8roSiJObfYCfVw98ErArRJ/u+u3E5zNsk9Fl6wgzSULDwaKpNa8JsBp
 nVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773070774; x=1773675574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ftQkCj7dl0BHtVdnSc70G0vnRqt+zl2O9gw+jSpGoE4=;
 b=k5T7xEcjt1mcyx9XeFDVbdfwz23CD3uuMK2Lk4jc85pLRMQA/ufO38JuShD7rgH3ca
 BMsj7r7lvwqYFIr3hPQRy3eNhqzXOwFpfSHedEs3Ss9AoEH5ZPb52Svnvd8vh5fUF3/C
 34Os3oRJ021G/99Isn7fGDXmurXan3d0EL57EKd45gc+KQjL5ThMFP6ZIFZN0pgeiO5H
 XpEtLEVAAxpf7c2pmLP76SzwM+bHVTv18pUqrRs923J/YYVMQHmxsoThBwUUpZ5tV7ez
 vV6+qsZVADaE74KW53l+1MUQTRMSXNrr/8QuscnYOD/7OLMt9aRk4st7StGUAvaJKlWq
 QI8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV97JNd16ENQUmWfPFm7zbPHsWzAqqi0FRGnOZUmmXFW364IrQqacZ+NjsOACQtZafT+l+uD+3Sk3U8@nongnu.org
X-Gm-Message-State: AOJu0YyCLZHlmrnT2vi8zrp8XDjMt9fGAeaNughPpp85QcSTTDlgn8T7
 OB10TqexPtL3+bOf7WB5EC+TEaCTMjMXw1boL6pZ488T5Z1aXNEC5k6rM89vKpctUAnGph4Mtxo
 q7QU9WQRgXgz5q1Pj1PZR0BupPsDj77FuvBjqSmEaGBATNXqlgEKFqrW/Iy+4P1Ka
X-Gm-Gg: ATEYQzz1H77x/vyWZJeO+3hnaaEhueomrjKZLpHUDqh3DwfRqOiDir2FniYLNRWAMe6
 2/8bZ3joME+oDtIC4nKaJna9UkTHQQUD4y60lbs0w5LZfBprgS9rK3oKu9JpPjVi/yuezoxLt/j
 U/mSRJfWL22Up0l4q+IKXNB92nq7yN/tqEspi4D2UAQA9L6xr488HA6zd3127Bf36Fk/uhRdp1L
 R85gfWRO02c8sZ08iZ+H7T9CO/LYl9LZZUrZ9Ngsgy1eHpNhjyTTmGuSvK75ShfpOydgVlK7abE
 9I2gKV6srrOYA5Fu2t7+lk6oaRNo+8p1G5VHBPcquIIi+b/YHRPNvLf8yBZ/4YZgbkeblM7g9P9
 tRyFPTbE3/94o8zhHBKeGvBsnXbsy75Gu1mNYbn0Md+bqTBLwFqXmJT6uUAJjj5oONFOvYpTco8
 PjNrvHSg==
X-Received: by 2002:a05:6214:3002:b0:89a:321:a198 with SMTP id
 6a1803df08f44-89a30acb78bmr168263076d6.45.1773070773612; 
 Mon, 09 Mar 2026 08:39:33 -0700 (PDT)
X-Received: by 2002:a05:6214:3002:b0:89a:321:a198 with SMTP id
 6a1803df08f44-89a30acb78bmr168262506d6.45.1773070773013; 
 Mon, 09 Mar 2026 08:39:33 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a57a18315sm447596d6.6.2026.03.09.08.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:39:32 -0700 (PDT)
Date: Mon, 9 Mar 2026 11:39:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: assert that the same migration handler is not
 being added twice
Message-ID: <aa7ps81lguxP9Thv@x1.local>
References: <20260308100148.162503-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260308100148.162503-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Sun, Mar 08, 2026 at 03:31:48PM +0530, Ani Sinha wrote:
> Currently the code that adds a migration blocker does not check if the same
> blocker already exists. Assert that the migration handler being added has
> not been added already.
> 
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Peter Xu <peterx@redhat.com>
> CC: Prasad Pandit <pjp@fedoraproject.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


