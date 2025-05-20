Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470A1C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQNj-0006DH-LF; Tue, 20 May 2025 13:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQNh-0006Ct-Lh
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQNf-0000Nb-FU
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747760630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H0CrEaFpy2FATSZ5oQl8Dbuv2nZXlai7cKBlFwBodUE=;
 b=JOOJFrgOxrevsbqmTob+GZTm7OEKHAFe2vn/FQz+h2yiRjjNp0NyfVjrIyhGX/rBO7atNq
 PT+A81ydPLMZjRhdMCIIhAGyPPp/mfw6CsUYAuLeopzHuBMfqqj91cX/5TTZ6YN2lkaW8L
 tPIlSldznLV1qlttfAnayeLZDUPgOJs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-Pv8cqHzIOwSLYMslhz4bzA-1; Tue, 20 May 2025 13:03:48 -0400
X-MC-Unique: Pv8cqHzIOwSLYMslhz4bzA-1
X-Mimecast-MFC-AGG-ID: Pv8cqHzIOwSLYMslhz4bzA_1747760626
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6f8cb4b1861so52513396d6.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760626; x=1748365426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0CrEaFpy2FATSZ5oQl8Dbuv2nZXlai7cKBlFwBodUE=;
 b=GPmcMpLcfoSOt9UUkca6wCuFDbZ8+PVT6FMh9RQmSKH/dLgEkaVbz7oRTuIvue57Wc
 zurjOin/92yKx/DDULUyy741RsOB9ldSm9ID4qszA1vUMW3VYSZcnRjWAvQapQPVQnP+
 p9jWgLMTcxxeULgGfzKxFvYoD+JbCbGIRdEVUUCYcEyzvLComiW0XrwR6tEx4d3syJhh
 etgvy3vdoHfmC1LRy09wQLqv5iXB+z6vWPCDdyGWs50kYnElQdUghXxym7c6eUhBZ5yC
 iAzjFjmpCqwIOuWAPPz61pvP6blm94WfwUwQ9gNTzG5CZILKo1stPWPlVqstyC8iL0y5
 BDHw==
X-Gm-Message-State: AOJu0YxktCDhue3c+TKKJl3iqdleI+QaGHJVbWTyYWN+b8avfjZgFubs
 qjad+U5QwXM6PJN+W9FoEvoICgE5AYEvUfJwhjt6enXn+V5hMt26+77ChEj0crsfhrOCyEGKRUA
 zxKk6FVhb0YolSpuxoAt0TPoSAesbCfdbpyLyRmZ/cGL8Eerz30pNWGyn
X-Gm-Gg: ASbGncu/SM563vfjXNkiWtnlg/yxgeMC82HPV4tZw9ws9fMOsvsTxCgtCB54bLsrIKN
 Ed8R0Wk6W3bU4kC2hEcsXzhxUhkNrwQ41b8UDHZY8et8IKNupRR02zYv5paBqGmazaAUK7wABhs
 67gFkgryTkyFAlHvseKlyVi2M5F6ZEHjECnvfYvoVczeAZR1/mit5oO/RKlO8g74z/j/nAMTrqS
 YTQtAeXsNbLq0d1IQkd1Cj0rvIMuoG0YOTCb8M1mlmrV1enMYuGM7H7D0ZKQeg+L5T6eGeHJ63z
 uTg=
X-Received: by 2002:a05:6214:16e:b0:6f8:bfbf:5d29 with SMTP id
 6a1803df08f44-6f8bfbf5dc2mr194643856d6.5.1747760626434; 
 Tue, 20 May 2025 10:03:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBXFYT0m28XPRtrX6U6+je5vU5NrXUD5ZEWU3RZeWLIKbnZzISuJ1ebCkg+OBzRQl6SKrqng==
X-Received: by 2002:a05:6214:16e:b0:6f8:bfbf:5d29 with SMTP id
 6a1803df08f44-6f8bfbf5dc2mr194643446d6.5.1747760626003; 
 Tue, 20 May 2025 10:03:46 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f8b0966098sm73670566d6.82.2025.05.20.10.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:03:45 -0700 (PDT)
Date: Tue, 20 May 2025 13:03:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Mario Casquero <mcasquer@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 0/2] migration: Some fix and enhancements to HMP "info
 migrate"
Message-ID: <aCy17sy1BRaVy0lK@x1.local>
References: <20250514200137.581935-1-peterx@redhat.com>
 <CAMXpfWvhQCXa_tYGnf+e=vrt7XtrJE4Bxz6BnO6fnS_OU+8s6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMXpfWvhQCXa_tYGnf+e=vrt7XtrJE4Bxz6BnO6fnS_OU+8s6w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, May 19, 2025 at 01:27:35PM +0200, Mario Casquero wrote:
> This series has been successfully tested. Now the HMP info migrate
> command is more compact and readable. With the -a option the values of
> the globals are displayed as well.
> 
> (qemu) info migrate
> Status: active
> Time (ms): total=4029, setup=36, exp_down=300
> RAM info:
>   Throughput (mbps): 938.03
>   Sizes (KB): psize=4, total=16798280

I just noticed there's the comma missing at the end of this line.. I'll add
it.

>     transferred=426629, remain=6121884,
>     precopy=426752, multifd=0, postcopy=0
>   Pages: normal=105457, zero=466489, rate_per_sec=28728
>   Others: dirty_syncs=1
> 
> Tested-by: Mario Casquero <mcasquer@redhat.com>

Thanks Mario.  I'll queue this series with the touch up.

-- 
Peter Xu


