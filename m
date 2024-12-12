Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AEBE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLn96-0007gU-C1; Thu, 12 Dec 2024 12:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLn95-0007gC-2N
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:38:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLn93-0001lC-29
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734025114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kl0ViSV7xfxONf8bttvRlnnlZ952fHyVTUerpeS+pSM=;
 b=TbLDTpt8h6mw6TV1yNHT2ZEmtKN1kd2vuAgauOEvAGpQME880hwHHTV6Vz+g63pRoY5VfT
 LzXqHBs7YHz9Mv4dtUXvtSXTohG5OaesnIwOdE7+yLohp72wzJURR6W4lu1vz6xncarywJ
 LlS7ZcBYnKPygsf58KjyHggDOmVav9g=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-KSuKZZolPOW1UEWtHAMSKg-1; Thu, 12 Dec 2024 12:38:31 -0500
X-MC-Unique: KSuKZZolPOW1UEWtHAMSKg-1
X-Mimecast-MFC-AGG-ID: KSuKZZolPOW1UEWtHAMSKg
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-844e5b72c69so54226939f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 09:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734025110; x=1734629910;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kl0ViSV7xfxONf8bttvRlnnlZ952fHyVTUerpeS+pSM=;
 b=MWvxUXMdYnRGH8G7xlGMB/wG8gYEkd1oWqCA1VssJ/vlnfHGlQL+K+Coc1o/fzIFiI
 nuR6M7ikpS3/3DOZ3yjoodim+ErgzugVStnGf85w3+q5ehY8q/LeVyqCDGW9bD4I1lq+
 gas1iI30E6fAZRwwBmFH8BBvBjGkuIXIHySOhGsTJZ3ATMUvlijTTx78HvFDIFF8N6th
 aM2oqmO+AW45zKYGu2SV0HKfapzoiw5zFiDfTOlwgkXgJY0UrNQWFMesHjl8JSbK62OT
 /n8r50/VZ4uKE2MrB38Uxco8UqNFebG1OJl+JQ2Y1Pi6p/6xE2MltNUG2EeR2meavp3M
 E48w==
X-Gm-Message-State: AOJu0Yy9zmihLSV2aD4Dv4ziB7pwhwc3KljHmxgJdkmV+o8dXe2QVXSH
 PdV7GlsOe6/0QsiSlmZkp906ho7CVCMfUBy+i2wqx1kjFcXqabhtrX+y856Qfq5fDORqiiil+nS
 X21HhUdi7zGJWXYL+dZ+T8E2BoU0OjVsRuTRXuZf/uDeu8DA8oiBK
X-Gm-Gg: ASbGncvkHFrmHhLdIOOh8dlVnIb+sjIMpMKYqi+nOfgLUchpTlllO6hkCmLq9FbS46G
 oK+kTuyiere+Q1FIofzGRw8HqQ7H1nv2TXUf5ANJnTK1FGEkt+9SMLDp/+EANAQPSu8KCAntuhD
 VP/EQ4103oE51MdjCqRoSu3wKUNfi+PtuGD532Frqo24pWYM6MUKlggxGzPBmZw3jYABmzyTMkU
 qOow/an66wprPrC92Rs3yCuRAvsxTVaDkFGqXHDm6Z37NvNEO7OtQ2TQ6uyav2UKfrr4tvf0Ktp
 3NTIQpB92/NEwwQ3Kw==
X-Received: by 2002:a05:6602:3f95:b0:843:ebf1:16df with SMTP id
 ca18e2360f4ac-844e56aa60emr148672739f.10.1734025110543; 
 Thu, 12 Dec 2024 09:38:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5GRSFNGxWvXk2uo+3YQnWk+QTngRDHfgibESt5ECk4mCZYGw0RqGega0vbnnCPi+KVXyJRQ==
X-Received: by 2002:a05:6602:3f95:b0:843:ebf1:16df with SMTP id
 ca18e2360f4ac-844e56aa60emr148670639f.10.1734025110311; 
 Thu, 12 Dec 2024 09:38:30 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844dfd753bcsm33977939f.10.2024.12.12.09.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 09:38:29 -0800 (PST)
Date: Thu, 12 Dec 2024 12:38:27 -0500
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
Subject: Re: [PATCH V4 08/19] hostmem-shm: preserve for cpr
Message-ID: <Z1sfk334WQqAiUSm@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-9-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1733145611-62315-9-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
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

On Mon, Dec 02, 2024 at 05:20:00AM -0800, Steve Sistare wrote:
> Preserve memory-backend-shm memory objects during cpr-transfer.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


