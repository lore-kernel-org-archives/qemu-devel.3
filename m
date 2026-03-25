Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AD9109C059
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Tuh-0005cA-42; Wed, 25 Mar 2026 15:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5Tuf-0005c0-RX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5Tud-0007Si-M8
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774466945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YIIjpGIYHMcim7ckn3rjNpqIdyIStyEpF768RxPkmuc=;
 b=CjHPMW71aQnmEFBcSXTmt2uQ+7Oo0EJmtiApmWEhuCK6UcG4vmbXciM51WSezOkrhHBQ3h
 VTSRnWKTOr1ZU+r5BqshsHXKrW1ga7XkoucujIk9cQdQDsjCHcAw87COrw/aetgtekUzfd
 WD9RPJsU92XdjoWjjyFrhPGXP0jMaQ0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-sICz0jR0NRysifkkcyMR3A-1; Wed, 25 Mar 2026 15:29:04 -0400
X-MC-Unique: sICz0jR0NRysifkkcyMR3A-1
X-Mimecast-MFC-AGG-ID: sICz0jR0NRysifkkcyMR3A_1774466943
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso8534221cf.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774466943; x=1775071743; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YIIjpGIYHMcim7ckn3rjNpqIdyIStyEpF768RxPkmuc=;
 b=sv3FgqjNy1/dxkvErnj9wdws5vGnnOKdzAeXQw5dDaUDYBHxyt0gnGWIPf8MRkgrs7
 ab8qRsClW6CmNinBMjhHE9t+8ZbV3kH/rt6x54yjOcOI6AB8cS5t4pc/Uv12APTUGkoE
 36ItSn28TT3LmDO64AL1DfgRaY3sva+5Am+LViOVDJAiNG+wwa2lxLN+Spgf0jTaj5/Q
 vsltRXzxmV8iYCSkEy4LAmKTp407hvkPYCJ9sXbSnqORHR8XaVKtUdFyNCXEeikJZ5GP
 H0hhUSiGihaNXR8YnF1zG0zuNKNaNy1xGDzyoBF90b5HbojFttqxGK+SZ4n1/slkElNY
 TgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774466943; x=1775071743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YIIjpGIYHMcim7ckn3rjNpqIdyIStyEpF768RxPkmuc=;
 b=ZKFc5YrmxK+TVIMYMF0gBVur0EjoGt4YpddUmriT/wV5V63PzQNIYZfhJ/8Xg0T9sn
 l7We3DdPlfMuR4Zi6nHp1WxXkaZXrQQoxrmMqpHbFfRhmxL3q6ziB/IyvBotmXzI4frF
 +142xi2nzQtqb74D8y2thCdW6u8CqFsdOjxrl3hlYVv3huyzi7h/eRp4UwpvaxKCBtrX
 +RxiTdshebwKosoYJJXH96tDdsQKzxu+NlJtu/U04kRyJBq+VGdubbP6Pkc4SMJ8Pzod
 yFE1/u+N8DeaqEoZo5WQ9c87Yp+OIVNLkFvuiy5Q3ZlSTqaTzSfN8lJTPoYiBtL0s+az
 stJQ==
X-Gm-Message-State: AOJu0YxvzfNAStpw0tIvHmfRQb5Vc++NbW/xXmoe0s3vyVqsKY1912OY
 cLjf94eoApTRR5R54CcILaBLKNj6KTfbPm6bHjht7PARiUzhZ8goay7YxSl9ajCqua3OsGTaF8X
 cPHBX3BLT5XqAHfoAxy+73aCkfxjcEMNttkWC7qMwy6JOG4vO93zxdraP
X-Gm-Gg: ATEYQzxUxAOicjVZ0MNxvqCQw03b7raZF/ZehT5NZc5LbfbwdugFo/BZ87HUfSxweDe
 Tk8xqqGum4z05c9EEu7+lXTVBseKl4vA7ibRfi2jLQA/G6JxnAPELfQG8QPUQVTGUlowz3UCkzy
 iY/vafhpWhnCUhLLyPsb2sipURK/x1Smry6Ealmz0R4W61LG9+JIwoMHGqwc6BTix3tv42dbPDm
 nUfaPYmz+FVA5HTRCQ4gpG+KktGQbwGwcEi8Q3VlCh2ip1wc/s1iEUpByLrIYufd4Y9nfHJRwhO
 EyUaXbTk6Ulb5MuEzQj828bOQhKovDlFa5Sfvzk3TLshrSsPDUcb3PJVniSUTb9LYaCk0EmSTGZ
 HCdy5JNGBG6KxeQ==
X-Received: by 2002:a05:622a:5c17:b0:50b:5024:9091 with SMTP id
 d75a77b69052e-50b80eb20d8mr69019351cf.68.1774466943228; 
 Wed, 25 Mar 2026 12:29:03 -0700 (PDT)
X-Received: by 2002:a05:622a:5c17:b0:50b:5024:9091 with SMTP id
 d75a77b69052e-50b80eb20d8mr69018891cf.68.1774466942600; 
 Wed, 25 Mar 2026 12:29:02 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b9214a72asm6277311cf.8.2026.03.25.12.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:29:02 -0700 (PDT)
Date: Wed, 25 Mar 2026 15:29:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [RFC PATCH v1 13/17] vmstate: Drop VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Message-ID: <acQ3fae3pdLagfwV@x1.local>
References: <20260324194333.30004-1-farosas@suse.de>
 <20260324194333.30004-14-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324194333.30004-14-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Mar 24, 2026 at 04:43:28PM -0300, Fabiano Rosas wrote:
> The semantics of the VMS_ARRAY_OF_POINTER_AUTO_ALLOC of allocating
> memory dynamically for an array of pointers could be thought to be the
> same as the currently non-existent combination of VMS_ARRAY_OF_POINTER
> | VMS_ALLOC. The code is now able to handle such invalid combination,
> so drop the new flag and enable the VMS_ARRAY_OF_POINTER | VMS_ALLOC
> combo.

I was intentionally leaving VMS_ALLOC only for the top layer vmsd field,
but then.. I think you're right, there's no way the driver code can offload
the allocation of top layer vmsd field, while without offloading together
the pointer allocations inside the array altogether when it's
VMS_ARRAY_OF_POINTERS.

Let me see how I can incorporate this change, unless extremely awkward to
rearrange, otherwise I'll make it not introduce this flag when repost.

-- 
Peter Xu


