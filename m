Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DD1CD0406
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 21:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcrlX-00023D-4h; Mon, 05 Jan 2026 16:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcrlT-0001xL-98
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:05:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcrlR-00046N-R5
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767647120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dFl8zrNnmghi207llSPpQ7e8QIY84AJ32ZP8llWrl4Q=;
 b=FjkpfPOUvRkwkkRtaQrjKrkNc63DiU4M3zUr0LkdhYOCV4kJzTBXjKTOc+/o6cTT4ajn4g
 2htA6HWINYej/fbwJSKqxl3owMMcCH5cJe5eyJMXYURbTXQkx8b+zpJca9SpWx+Jm5uIEG
 5HOGHfw3f4KvSxCL3HNUUm8DtXezWbo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-44djN9erOg2Rw7wbEG_c5g-1; Mon, 05 Jan 2026 16:05:19 -0500
X-MC-Unique: 44djN9erOg2Rw7wbEG_c5g-1
X-Mimecast-MFC-AGG-ID: 44djN9erOg2Rw7wbEG_c5g_1767647119
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b1d8f56e24so77642885a.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 13:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767647119; x=1768251919; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dFl8zrNnmghi207llSPpQ7e8QIY84AJ32ZP8llWrl4Q=;
 b=RetcTKtYBrRfqU96PyGkBWNMzST2R9v3TmGPtWSoh1LA4F2i5TcBiMU/aal3r0Tg0y
 Z8lmkHyhLFIX+39IAL2it0ayXUT0GBMhu52Fcazc5vfBM15NVPzHtBbYgyp5ico7R7CC
 gTEW7echlsT0djgu93XigUwjl+/n2eq2ohm+awuA4xBv0ylV9RLC1Ja7zcrioJ/g0S0E
 IBRzdG3OTJQT/CV9EbO8jGmBDDOpAaQ9ELzuyRW69elbHr5M44/BrrW1KOsjVmh8XKPO
 0WMfpcuHoI+C8374w5kuxN+0kQk1dW8ruCScU67ncZj+3DIQY63la3465ySgiCU0ZBUK
 0t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767647119; x=1768251919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dFl8zrNnmghi207llSPpQ7e8QIY84AJ32ZP8llWrl4Q=;
 b=a3mq7wkyE6y61Ac/JRzPhJ77G9vhBwF+Z6vEaK3rBdgvLSE4x/cFvjThBGktPWtonn
 evwBA66yOREhXjMBHqVOeSNUZJA+aDCi8GCZsGJmTpE5Sa/hw3AvbIRHlBKJq9inlb7J
 lFrhIzjckmGaxp+YDF52ca5FpZMCxN2Yi0qt14rMU6rs+KdgbNbPiglR0IL6mhk8zS3u
 1vsLSDw4DdmNUvHvr+mwW18rXdbcoGcJdx1niBeTpKRRvExOs3HgmXNJr+CcH7niTeeS
 mZ838XkRgW4FqgAUDNH4/NC6XSqRlLFOKzNYiWqR3VAnOO8zYrpr1RnlQn7bze/lg76A
 VVKw==
X-Gm-Message-State: AOJu0Yzn55RimCxUCiTWYBQfmb0mIbtTVRArUdmPkDcxIHPViiVFfIaF
 33w+m9dL/cow/WAsM5eRozSMJ8RBAoDbE5WqMSlGF79p3Q2KZPUxt5sQADhCITnJOKd7N1ECTch
 iFtkMMIKHVCiWGLG891RpOJLBPiRZZviqHz/n5MwBsjxjskTIXxy1lhj0
X-Gm-Gg: AY/fxX7kuygHblphbMxgQFvb0vrf6kw0GzH6bSlAYaFWXzuBBETvuNtLduMuvMq73AC
 WB7PuFqc6ItSpo+L0oPdevhlIq26owkKM0R5qmrSmWEqEI0uLVrCISxKMZnr19WmtrTA7q9eI5y
 FxthE1Amr66/ibXEFydhTph5gVfMhNwOe20ul58nuGpMgq5au1iVBCAVWHsG3sZJNz5HPETIHx8
 67uprqjmmZ148uQpfsnDLZ3ZxVKYnvUhuQQXPwRS4adiAXny2wOWeNldluWlGk4isdA7AI0Hqw+
 7IbXEA1BDJGxs7l/+6X7GutQk5k1ZK1Xw9CisS6MgCqsOW5Grx9NSFDxQ+piiZP9If3eKANZBfn
 c09s=
X-Received: by 2002:a05:620a:bc6:b0:8b2:eae0:bbf4 with SMTP id
 af79cd13be357-8c37eb49ef8mr139732385a.19.1767647118721; 
 Mon, 05 Jan 2026 13:05:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFra6AFxDQdi4Od5xwpkVRPfW2rnjzhJqjqkuxnHf+5OfO7ATMPX6/3fbeeeP7ARNaXDdlOlA==
X-Received: by 2002:a05:620a:bc6:b0:8b2:eae0:bbf4 with SMTP id
 af79cd13be357-8c37eb49ef8mr139707085a.19.1767647115524; 
 Mon, 05 Jan 2026 13:05:15 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8e65368sm1000411cf.32.2026.01.05.13.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 13:05:15 -0800 (PST)
Date: Mon, 5 Jan 2026 16:05:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH v2 23/25] migration: Move CPR HUP watch to cpr-transfer.c
Message-ID: <aVwnicElzUSosRnE@x1.local>
References: <20260105190644.14072-1-farosas@suse.de>
 <20260105190644.14072-24-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105190644.14072-24-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 05, 2026 at 04:06:40PM -0300, Fabiano Rosas wrote:
> Move this CPR-specific code into a cpr file. While here, give the
> functions more significant names.
> 
> This makes the new idea (after cpr-transfer) of having two parts to
> qmp_migrate slightly more obvious: either wait for the hangup or
> continue directly.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


