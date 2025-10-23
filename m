Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E19BCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwNf-0000hM-Jz; Thu, 23 Oct 2025 10:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBwNe-0000bG-Iv
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:33:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBwNW-00028x-9W
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761229999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g+DEaRGWFavcvPAdzstc9Bst74ovSImAqm6Qi6wTsoE=;
 b=WTbT+zkDXBJiHgDCnBDN/4Sk4PVftORywTWoFmBDxvMmSUoI5neJdn78GsDYxoUfdhAaxg
 SpTUnsJxqt/AM4ACRKf3EOpq4fGazDDjuccmqYSduEEMFkC0lp9VYUKP9WDM9TW6+zfcq3
 IfwkVjcSchXajUJPb5sZ7X/I+ZvkcJY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-1vdkqPIGMcuRuJBAfQQPMg-1; Thu, 23 Oct 2025 10:33:17 -0400
X-MC-Unique: 1vdkqPIGMcuRuJBAfQQPMg-1
X-Mimecast-MFC-AGG-ID: 1vdkqPIGMcuRuJBAfQQPMg_1761229997
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4e8916e8d4aso41671281cf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229996; x=1761834796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+DEaRGWFavcvPAdzstc9Bst74ovSImAqm6Qi6wTsoE=;
 b=L7pu3zVbV4ec0fo+aW4oYFvlTJHhur0y5k5uNBKnTA+djKsAijZxwUwguDfUH8vABP
 aJ0GtCn7fAxaxW5P7HkFVRJb3++DhR/Nduv4AHw4ZXbL1Eqx3KXAh9RjK3D4OyeBVDGi
 nQZDLCQHORdUXKIqMlwtWLyGUl2FKBnuShrovcO92utk2qQPqX00dCrXjOac3C7ex/3g
 O0Q9VVU4CuMfa3CaRNusOLCz81HNkbCxccqh6ErVTfZjwkonBFpRkW7tO1bFniqJj1ag
 OVV7c8msHP8xHXXVQkYbLvtpGS2x8Xxsp0PQ6iWJEhGwkejd7meZcUOXXywT0CWWhThD
 di0A==
X-Gm-Message-State: AOJu0Yx2p1zFVn1Cis4ExQ8lCbOO/TXE8/e7VYDEarLK2QxTSWhDhZ7C
 2aPyVufTNoxbilO3JU8eRbTt83aPldhPpFOyhAiNHeHtDUVAsEdCAwnrGf1plunDpSZhMPrtx6D
 3VJbeTzZCXGqdZwGOhnHOz8D1M/YOvI+5hVhwOSkLhbyzSnMW1XaHqhRd
X-Gm-Gg: ASbGncuXj80whxgpVUjanM8LJLnltuAYkGInbtwJHvqK32R6++JasX77qfS6cKqozWu
 lERPe458MTsUCaurQdfnFWO693FTD6OG1sc2F8CHZoVzUOiMs4lom1yE01y+HXQ/PIzqhsmR78y
 SEAv89Bk9r7heq8BoAuGiMCo74xFSlq7eXOxio7/QO6Fuq17Z0wsJFdhb15ybbGOQyMOSQcO9VD
 4fhuW/mVXKyUNjzjC2eOFdWY14Ioyg2xj5A3+PzAFT7b5EIqXkSs7yX7sh/E8wFAUMGWgOPBcBj
 /a8gfrt5w+3s+U3sz30ILr9bhTf+E3oAk3qwsLFg4/nmTgADQNANVBFBYiUFc74M4R4=
X-Received: by 2002:ac8:5f93:0:b0:4e7:216e:1fcd with SMTP id
 d75a77b69052e-4e89d35c9ebmr317131661cf.54.1761229996563; 
 Thu, 23 Oct 2025 07:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHied5OjtwhoYeyIx9Q7nJTiKxElPcQVirOIJ2rszQPPVyavsq0hgJZ2VfT8488dKEtsSlfMw==
X-Received: by 2002:ac8:5f93:0:b0:4e7:216e:1fcd with SMTP id
 d75a77b69052e-4e89d35c9ebmr317131111cf.54.1761229996024; 
 Thu, 23 Oct 2025 07:33:16 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87f9e7f6a19sm15982606d6.55.2025.10.23.07.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:33:15 -0700 (PDT)
Date: Thu, 23 Oct 2025 10:33:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 2/2] migration/vmstate: remove
 VMSTATE_BUFFER_POINTER_UNSAFE macro
Message-ID: <aPo8qL4zg3LEXMpq@x1.local>
References: <20251023135316.31128-1-mjt@tls.msk.ru>
 <20251023135316.31128-3-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023135316.31128-3-mjt@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Oct 23, 2025 at 04:53:10PM +0300, Michael Tokarev wrote:
> The only user of this macro was VirtIONet.vlans, which has been
> converted to regular VMSTATE_BUFFER.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


