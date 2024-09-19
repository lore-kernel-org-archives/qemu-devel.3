Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03E1CF3962
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 17:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srLDd-0005LB-HK; Thu, 19 Sep 2024 13:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srLDN-00053V-Md
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srLDF-0000zb-Is
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726767904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BhLYToOqL4tc/hlM0yff0jzIrH/qRLSSaBpoR4+ZBn8=;
 b=hSDd+iIowZmE7FAw171d5tqw3i1aRpGdwQDTD/Rjr7uB7Ing8xWLICNoMrCd4S24RvW/v8
 5MPbxwRYdcied7iuX1K3cbkuuJhG8zaF/lZfvEIo87e1TBBwPICfKkpYQ5ZJf5WvUWbsTV
 BNNYZ6g1s1C/mfbcpqWrKpn++ZLxBPo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-qpZtF8t7MNKV05U7m5OspQ-1; Thu, 19 Sep 2024 13:45:03 -0400
X-MC-Unique: qpZtF8t7MNKV05U7m5OspQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a9a6251df5so261623085a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 10:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726767902; x=1727372702;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhLYToOqL4tc/hlM0yff0jzIrH/qRLSSaBpoR4+ZBn8=;
 b=l8LZVrqYoHGT60T88uIM3lZLSdIJaONvbh46l9aKADxbnT8FRWNmb7CsqChgJEmmm7
 4VESpGbrp+KEiKUP4vdMfEY+KHPWTe8UwWD4IrnvTufiXmI/qb5mLFF7m7RUzFl7aYCg
 QVs789EiKk2boWHG6hlBKTdPCo73xtCjDY5wXjdeccx51bB7MxnF3Acj0BlB8ncMHGC3
 iMQe/8t/Loq61AUJqt7uzWCnEUt33dj5OHEHN8ZNjecqxJ3KjQ6IyhI6b0QS/oiWbyN+
 SVA6cqNqlbXJClOg/4GjRZxkgoXO0bdoK1/uJtE7nz9HhOpe08Na4MU3OI90JkgjHBYk
 pSrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKfrO5yAHZYBB9rrFbyFN1NqsssAvvrmLF+xaiWJg1kvUiIEJxlTfsdiafEaYiCNFOVAclOCsSJLkH@nongnu.org
X-Gm-Message-State: AOJu0Yz+Au70ewhw9ltMvscmYNQI3NphOCgyj5b/emzpRi4Hexpx3U9X
 sV710MRWklB8qaqOCmW5v49jzCtKkY7sqdTJ8Wwz55nx1LE7pBt6/AoWURs0+TVEG0TQSQCCxro
 b0DYzKYTx7F0ZuSw7mFhsjKcRojEZPfdPLG/dWmBob0Uc6WclfdBY
X-Received: by 2002:a05:620a:40c8:b0:7ac:b19c:2121 with SMTP id
 af79cd13be357-7acb8225283mr35177385a.63.1726767902594; 
 Thu, 19 Sep 2024 10:45:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNghkcFiLttXfr1gwTsFgKOv2rkAKBhD/Shw8jm9fbStF+WsOtJX4bglwJn6qHGSUQr0MHPg==
X-Received: by 2002:a05:620a:40c8:b0:7ac:b19c:2121 with SMTP id
 af79cd13be357-7acb8225283mr35175285a.63.1726767902323; 
 Thu, 19 Sep 2024 10:45:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb08ed0bdsm93423985a.130.2024.09.19.10.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 10:45:01 -0700 (PDT)
Date: Thu, 19 Sep 2024 13:44:59 -0400
From: Peter Xu <peterx@redhat.com>
To: dave@treblig.org
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 7/7] util/userfaultfd: Remove unused uffd_poll_events
Message-ID: <ZuxjG88xJ7VmiH6C@x1n>
References: <20240919134626.166183-1-dave@treblig.org>
 <20240919134626.166183-8-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919134626.166183-8-dave@treblig.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Sep 19, 2024 at 02:46:26PM +0100, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> uffd_poll_events has been unused since it was added; it's also
> just a wrapper around a plain old poll call, so doesn't add anything.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


