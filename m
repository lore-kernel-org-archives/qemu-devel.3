Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C064CA0EE8
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 07:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjwCr-0001up-Uq; Fri, 30 Aug 2024 03:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sjwCp-0001rJ-VC
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 03:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sjwCo-000421-8f
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 03:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725003481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hijOnSZ1jq1VwEIA3Ed/oXvm229xw2qxXc2QO2GRQ28=;
 b=NCettRa8cCCYhi03hZUGJWfe24yjqik/zJJYd1Ul8g+uGTz5NnqJDtCfGsMAHocLKSwRAs
 Zg6s5PnGeFB13SV2GdTLzy61vAHr17llc+tkrFdxchCytpA8FnPJsgQUhCyYTkyfsSc1FU
 gGYAt5Klbr0O7je17YBxm1/fNBN2wVk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-Du39K4OmPeu66gese6GFXQ-1; Fri, 30 Aug 2024 03:36:46 -0400
X-MC-Unique: Du39K4OmPeu66gese6GFXQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37189fc2977so1024152f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 00:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725003405; x=1725608205;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hijOnSZ1jq1VwEIA3Ed/oXvm229xw2qxXc2QO2GRQ28=;
 b=ZMrgolw0+hIw5HW2a5QZNtMTJh0B1LacHGFS3FkCHXL0d50WQh7s7g3Ijo2lL9/K1L
 6E1d+68WgXr64bS8/eohDviMACoMn/gO03+GArLeM2yXGYgB/lUdtTRppfMPLCtDGvnL
 iOPalhrAB/jGkUWK2B+h6NIYSTHBUDUsPuvjzhv4ogMlPqoBNj+6AOAQDlrwe5730DlS
 PIYiK6fY7dwqbMJm7zl6Es2j71rMFJaRvfRAc2KvOKENcIq/NefcGB8YGMia9V6v5bN5
 oxI0pM8WZ9lG6bAmPpXZCIp2tC4XXAJShrJ9aHrynhsNYoKCR02I0IXrM12JiapL0n2H
 krcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKjh543C2iNpg3tyf4NZf1dNl6yj5yC1xZgFeJeliE3XwoULx70GVPKa8iyczon3GD1pl4Vdnc7buC@nongnu.org
X-Gm-Message-State: AOJu0YzjWJKQAPkt4CJD39BPHRWYgpJOdUd4MtwOINtitxgIIUmQbp6r
 QovOBwX8zzMzQpPHla2vsvk274fML8LMEYbkbBGohS9PtTmOUDQWiB/zjQDF8H6soohONOatanh
 StBERlLZgNiyPrp7JujLg6AEOovJbIYolGHQ0kQIMrYrtKsyPHCsM
X-Received: by 2002:adf:a295:0:b0:36c:ff0c:36d7 with SMTP id
 ffacd0b85a97d-3749b550126mr3311082f8f.2.1725003405424; 
 Fri, 30 Aug 2024 00:36:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYWgSxbQoG2nD5UyHTa9DqBFhT1fLuakH2sAU6iWvZoJH3rHTPpKk+yCSXi3hswA8hPPdR5Q==
X-Received: by 2002:adf:a295:0:b0:36c:ff0c:36d7 with SMTP id
 ffacd0b85a97d-3749b550126mr3311059f8f.2.1725003404680; 
 Fri, 30 Aug 2024 00:36:44 -0700 (PDT)
Received: from ?IPV6:2003:cf:d748:138d:7ea9:6713:593a:3e11?
 (p200300cfd748138d7ea96713593a3e11.dip0.t-ipconnect.de.
 [2003:cf:d748:138d:7ea9:6713:593a:3e11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749eeabcb1sm3229140f8f.60.2024.08.30.00.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2024 00:36:43 -0700 (PDT)
Message-ID: <0061d31c-a8a4-4795-ad44-c32c0dacbfa6@redhat.com>
Date: Fri, 30 Aug 2024 09:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] raw-format: Fix error message for invalid offset/size
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: berrange@redhat.com, afrosi@redhat.com, qemu-devel@nongnu.org
References: <20240829185527.47152-1-kwolf@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240829185527.47152-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 29.08.24 20:55, Kevin Wolf wrote:
> s->offset and s->size are only set at the end of the function and still
> contain the old values when formatting the error message. Print the
> parameters with the new values that we actually checked instead.
>
> Fixes: 500e2434207d ('raw-format: Split raw_read_options()')
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/raw-format.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


