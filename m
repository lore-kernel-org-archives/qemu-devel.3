Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68872C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtUg7-0000ZQ-J4; Mon, 10 Aug 2026 14:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wtUg6-0000ZF-2E
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wtUg4-0004KY-P8
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786386288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BvTfnDxqvPZ6WkWTNmHoyvgP1kxm9wu/5znqcHj/KCQ=;
 b=f3i1/TL3LIvtUdLmXtspjm+E696DDZNpHo5x8w1tCMVKPdkY36w0YXDkk70lMGTbCI3HR+
 sCVPk+JGjn2670c9bBD4fLvczo23z94uflguZhE5psJwgnPhfpNp8C1qW59aQiN5AQ3CQ3
 VsvuyBION38+U6SySC4mV2IMZXHs0rk=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-gb1SNCfSNTy6rUNr5afeKQ-1; Mon, 10 Aug 2026 14:24:41 -0400
X-MC-Unique: gb1SNCfSNTy6rUNr5afeKQ-1
X-Mimecast-MFC-AGG-ID: gb1SNCfSNTy6rUNr5afeKQ_1786386281
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-756261d422dso2031144137.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 11:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786386281; x=1786991081; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BvTfnDxqvPZ6WkWTNmHoyvgP1kxm9wu/5znqcHj/KCQ=;
 b=tWpBGYWh3z6WsAwf0HKpweduf5iFyhLXvRWQjG2thRxg8/WtJJhZ8Y5XDFErxGYGf7
 dy9uPQ8CFQX7Ee399rA+VHDf0ZUb3f835wMUEzJZu6Lrm0wfefKKP8cpmlHSC0KelN2a
 IgMw3+b6sG1+XEgCES9t+I7EeWF7OC8d2wt0RABBUM/Tsl7+6ds2DkofxG8KNku/QK+D
 UdC9MQHE9CEc2/QQuIgqwYzs/nKmzz3edOLJdh3ID6Zao6R7TA35T43fxsImjBmBj22t
 ODgpDD4FF0V/r0eukgH21VTJSguPA/64tJ9EGuAe/hlbXhXHPBrEQE8mqtlGp8k+M0cC
 HJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786386281; x=1786991081;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BvTfnDxqvPZ6WkWTNmHoyvgP1kxm9wu/5znqcHj/KCQ=;
 b=LWXSOwx9o79nFNmy2Gtn1pmIOaXkOTYuRNsz5lofw3nbP1Vb1YqsP72WIz3e7WtfwB
 Ie+We5lHjnFMma5LJmwioSLhL5cJpsWyMRVoebzp6cH6Z5cYSxDq3OUQxa8F3FB7PO/w
 H7viZ3257JsGro5IMa5c2g90nqtQ+bwW/drjoeEgBbvKyb7eDpGDdWWyq6JSQnQ1u/vN
 C/cKDo28yubeJakRyoOtmcpukbAMTdlYyCOvtOMhRoG9ATqpYqpuSOLvVoyKkOu1urP2
 sygUSJGSYWc7JgOvxUMEZfCzJJf7gJtFzbeHqRsrTJO+TzpFN0ELfHEhueRrLwJ5vQmF
 pWNQ==
X-Gm-Message-State: AOJu0YyKgEMkOqt7gz6dlapCAmoNJkSnUutlqKSoAftD8bnS72agyTxm
 AInYOeVJJdfc6cFfiaa34jn1668wwQ81mZFaWaNbNL0han/ukygpUYHbozPrx1hL2UpGdnmTOVi
 BgAtFhounM5q7eoi4YKwr63g4kCCQ+DsI3WgkpNmD2EgH8f6jyBgfpL8S
X-Gm-Gg: AR+sD11mQHu36yb30TrZhKlb9u6uDBGLVwgbTLHZoKceLKnv8lfuqWMatnPRkd/ig5p
 QcmQS6RbWT1aKSQYH7kLNVVy3qHHnorh7+CPKFoiev1A+Oual98qVtpf6T1q+c5ku8Uty3uoMpM
 /0/hE4h3ecc8T9ecjRFRMO/A3mVkriR/lOX9BERQ3hNIMexN+8XXRrssIIqZrS8t171065LwfMe
 DuGFp2uDnI7IfcM/aAGjkE8hYXU0QaxIUdwSRvQPMIoMUE9HEPoKa4U+bNOBTZMRo3dZoQhAUs9
 F20Le6z0gzOTrcv2yUHm5ytcR4avGlBdxKUKwNEh/WZaJiEuINcZyEhPWISw7VTHw0iZ
X-Received: by 2002:a05:6102:374c:b0:738:3525:43ff with SMTP id
 ada2fe7eead31-764e7cf067cmr5942870137.13.1786386281178; 
 Mon, 10 Aug 2026 11:24:41 -0700 (PDT)
X-Received: by 2002:a05:6102:374c:b0:738:3525:43ff with SMTP id
 ada2fe7eead31-764e7cf067cmr5942841137.13.1786386280683; 
 Mon, 10 Aug 2026 11:24:40 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-979f303c3a4sm3960127241.10.2026.08.10.11.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 11:24:40 -0700 (PDT)
Date: Mon, 10 Aug 2026 14:24:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 11/11] docs/migration: Add documentation for fast
 snapshot load feature
Message-ID: <anoXZJjz7YTwVFSt@x1.local>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-12-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260801023628.22665-12-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Aug 01, 2026 at 08:06:28AM +0530, Aadeshveer Singh wrote:
> Add documenatation for fast snapshot load covering an overview, the
> architecture, usage and limitations.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


