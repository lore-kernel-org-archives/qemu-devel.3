Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CEDD46605
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 17:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgRK7-0001P5-Ko; Thu, 15 Jan 2026 12:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgRK6-0001Nf-3w
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:39:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgRK4-0006Fl-Lw
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768498791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4UJdRMdA3UFNWY600E2FQSIBFJFeCjBZCbZPoBabWU=;
 b=O9X8haPRJDZ4z7+4siDWls/MJDMmQ7skKk7v3j2zXxdK1T6t/M+c/aWEOF8Jog+qwZPIqV
 ktB8m6f210JjaPszI70P3xoYApK7I2L4oVMK0YKLjPK3NBMHV+gWmTDsLHfflKAnox7pU7
 x0Ocz1tyOqRhqIO1Z/sG+cFwWLbqLAw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-uIez02TsPGuVGJffU7uPOg-1; Thu, 15 Jan 2026 12:39:49 -0500
X-MC-Unique: uIez02TsPGuVGJffU7uPOg-1
X-Mimecast-MFC-AGG-ID: uIez02TsPGuVGJffU7uPOg_1768498789
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c52f07fbd0so510915685a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 09:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768498789; x=1769103589; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s4UJdRMdA3UFNWY600E2FQSIBFJFeCjBZCbZPoBabWU=;
 b=C5bx49ZwsBgh3clkenEXNXHZXwFOgQuM50jgb9ZzNLTpMJl4O3I3dINQtmMgQUYAXX
 YbSVJptQwFlmYhv6MJ5APpJLgEhZRdRwNkVgiMypUAwzDDiUPfT+MtJDHEIRlDAK9apT
 qsQ8Z/fmHWqlpnm2oBZ+r7HIAxeXnMcUwhNoRFPyrMIhG5xDXlzHqPWNdNnLMcd/beWj
 HUPeD2SZ1NPjGbesN5oBJ6Cs07Nf4Hl8Oam1KKQGCsp5iD0NnehTOZUI25DbDXYAjYDY
 taHGp6lDLe7rtbG3ZZBGc19depjxERQZpsNIw/dhwn4tmYhsTBiK9Hc/zzjTEI59ukR7
 enXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768498789; x=1769103589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4UJdRMdA3UFNWY600E2FQSIBFJFeCjBZCbZPoBabWU=;
 b=K9dr5sFjuzpCIyNRWhzOm7LHS7wlvJaFbxgYdcuQcOEN9RT8hz4LcQ3PHRyq8Lhrc3
 MokgfeOUpO1TWQje4LfntXixjkt8iApN35fC1G7tfyT+XtrO+zFxlSRAWpfPdHCTcLng
 6M/dqeukLYEG3NzvvvAIYeVhITatLyHmOZBo/z43owHcnGn/SEa6p1U/KW8PMMKXr7RZ
 IafAuTQnL1kBkScrZs9+iMYRwW3EaLBtyEJy9X6GHvEwVJbCoqqvGY54RQtYLFcanmTM
 zGr8EEU6m5yCvSeE018Lc4Ic1SZvzSHtpqR8k7uPlONonCdw+Y1JUVDlGDDe9LlycSu+
 JW4A==
X-Gm-Message-State: AOJu0Yw/OUTzrSMfjAFLDhtf989GUbdEFA/s/kRAW2H3VJaoMCzpHMw9
 HfneMZC+tBlz9nd44cAnGbj2ttczkcD9UmxDovuRaMlfZwVIB+G6KhHHawbikpuoB/MOnPqb43i
 WXfhfHbPWS7i0zAk3z8H6uOu1oZIod168OFJBVCwGsPNCjhQcFhvad2Wv
X-Gm-Gg: AY/fxX6OR7stvLAtEkCzjNvCNLfixbbZZ181TZT8jwsORYFcxiJ0X+0Owwg75klg4A0
 V6HTxsDimCH0lSdYP+xPQTgUjGheFzafO3Z8cfBnv66OuCWO3WT/wqBBZYzuEnSUKn8jO48L/p7
 Wf2TANI3nIKf/9BcEVhg2AvNMuVSCYhpnwZ+A5QRd49p/zEhaUZQd1TT1OfgX5jJ35ZqGeoZgti
 1ZwB4vN33La6cT2+H22evo9ahmOcoyIv08CHlWbsY7VlIx+KEC6hAV0BCbzxE1ia+2RtNvYsLv9
 qgwlT5N2UCfhyhNs1doD9Nf12y5OTyKuLvcG/4BydKbBCj+6hvVPG8McvjwQKd6eqpU61LMGpJ4
 teXc=
X-Received: by 2002:a05:620a:4687:b0:8b2:87a2:9c60 with SMTP id
 af79cd13be357-8c6a6963260mr14390285a.83.1768498788968; 
 Thu, 15 Jan 2026 09:39:48 -0800 (PST)
X-Received: by 2002:a05:620a:4687:b0:8b2:87a2:9c60 with SMTP id
 af79cd13be357-8c6a6963260mr14385985a.83.1768498788530; 
 Thu, 15 Jan 2026 09:39:48 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c530a9feb3sm444742585a.19.2026.01.15.09.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 09:39:48 -0800 (PST)
Date: Thu, 15 Jan 2026 12:39:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 3/3] migration: Remove fd: support on files
Message-ID: <aWkmXQGIaacRrI_M@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-4-peterx@redhat.com>
 <CAE8KmOzAFJztQGvgEYHHuFbtafiKFg4QV38ZGK2DW+TpPGVG2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzAFJztQGvgEYHHuFbtafiKFg4QV38ZGK2DW+TpPGVG2w@mail.gmail.com>
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

On Thu, Jan 15, 2026 at 05:45:57PM +0530, Prasad Pandit wrote:
> > @@ -92,8 +94,9 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
> >      }
> >
> >      if (!migration_fd_valid(fd)) {
> > -        warn_report("fd: migration to a file is deprecated."
> > -                    " Use file: instead.");
> > +        error_setg(errp, "fd: migration to a file is not supported."
> > +                   " Use file: instead.");
> > +        return;
> >      }
> 
> * If we are sure that an invalid 'fd' is always the file one,  then
> maybe (if possible) 'migrate_fd_valid' could be renamed to
> 'is_fd_file()'. Above snippet reads that 'fd' is invalid and the error
> message says migration to file is deprecated.

We're not sure about it, so the current function name is IMHO more suitable
with only whitelist of socket and pipes.  The error message provides a best
guess in this case.

> 
> Otherwise change looks okay.
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thanks.

-- 
Peter Xu


