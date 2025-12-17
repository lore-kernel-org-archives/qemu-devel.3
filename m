Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33834D66BA6
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 21:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVz0d-000466-4h; Wed, 17 Dec 2025 16:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVz0Z-00045W-O6
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 16:24:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVz0Y-0005FH-Bs
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 16:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766006669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wgj1dawEeivXaJjJ9Pzseu96y1Jb90RbsHQDqi2NZtg=;
 b=OJdZETXakU9NFFIWnjzP29fKEShbK3NZ0F98wio+W0d/38nFG7g9Wongmk4gF3zzPB7L9a
 jJQGTdpwA8/8SUKVUR3NuRTENFbsaR11DV65PR8utGB6/p40/2+XXly6qFt4iipTEMpahm
 6pcRflT4zfvegsIRz1RcALunFCJpFBk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-JHJqBGhMOOCeHiRJqiCp2Q-1; Wed, 17 Dec 2025 16:24:27 -0500
X-MC-Unique: JHJqBGhMOOCeHiRJqiCp2Q-1
X-Mimecast-MFC-AGG-ID: JHJqBGhMOOCeHiRJqiCp2Q_1766006667
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b2ea3d12fcso1549476385a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 13:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766006667; x=1766611467; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wgj1dawEeivXaJjJ9Pzseu96y1Jb90RbsHQDqi2NZtg=;
 b=ZYfpPIErBM00kSGblEPG6AuJxO/EftirLkWSsuA1a9zvibygJOTGOA1CMrxHVr2VYK
 7wUiYa3u2u23mqb0mO3YHY7ZvViHdL7+QBjRM89p8nnD6KtksjtfVxNFnwejodKQlo9l
 dzCrlDpEZ86I53+ObXM1wWfDwck8geg2K2gQmuhTTZHgWOkKmouNWIh0fGnSUN3uk5wS
 jRW9f3kCYwyV6nr6M4EItrqd5x5PekJlx7UDHdAFDT17GOPV00zAGo+gUf2cridEgiiC
 VwcFtF64kIoDunNsUxO53x4Q5QXhECUqn1/TfMKQPSVb4VSDGGJ7n0GAFLgAdr4/7K2B
 fKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766006667; x=1766611467;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgj1dawEeivXaJjJ9Pzseu96y1Jb90RbsHQDqi2NZtg=;
 b=efsdXArwa7L3XYFnL3folNWzmiG9b1U5tF3ZYp5jpt4eVHJ3vnXK+HCn1yDlHei5e5
 GFGCs7wwQ21WUgCRzYXPda33bbZTmBhsgwB0SSYUu775J4FSgBl9WPB4WhQzpDoiAjVP
 Fa8OJsTCedAQwHWzyJkCLxU37uGbu+ejna5ULPcQ1Cj++eLLX0KSKSKXIddPlxbuj+KC
 kweqtDf9NukhZVBzRYSM/eTXX9LuWjl9tZCOQ90jH49VopjwMbpvszuq2zPD4ZL+x822
 AndaHLUXnBpYoacRGboDCZBH0l41x1F/Az/JA3bLKW1mL3bUNfxR91cpZ0NwbWxaXNJ7
 LsmA==
X-Gm-Message-State: AOJu0YxFi8z7UxLp/T6jkNrI6d4BYoDlX4HgY6DZoyPfnIXbX6IR2wF/
 BDYamLqfjWzkHC7Uwm3T4+KhAp1hgWWzmZO9LkSFucuUUGzXLONiZ3h2XRUC6zsSQxWbN5mpTDM
 q1yf05hSzhbYMNugrrP9ATpfAxSN/M+jKd5RqQQOFk55oalaq5gb6zv5I
X-Gm-Gg: AY/fxX64oNHM+z6TlLtvNSW5nqRsMfc0WEhxdlwJ6WrPHiV8qotnL1MEEEm6b8AZKjd
 i5rEluL3FGVYn/ffjNF8B7uv8D/IM4CnGOWQZrSatvY3OazN7V/hWVwihtXhy8n8vxGoTVTLkVO
 BqXix7ebSYFdEvi7buQ30/Jn+fkYL9HQMDNeO9myks6Q+IKFFes2Q4yOR+TJI+fduiwYHy795z2
 QzHI+KzvwgfdlJpdgQChLHem6mqbdPTRkk/KqykNtOMaseQb2va4J3yJ/4s5BO0Zb81jT1vY4m8
 o9Kc3GKAawmlvxuRQnyJ+gmRqYVktmyop8Ag5h3gbM/MtTrqPvlmpx9i9+EE97a1qfaiWPTIINL
 Hk2U=
X-Received: by 2002:a05:620a:818e:b0:8bb:ac44:bd34 with SMTP id
 af79cd13be357-8bbac44e574mr1524351485a.4.1766006666936; 
 Wed, 17 Dec 2025 13:24:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnrD4HfJzNXjYSRH19JVBRTqJdg+PgIqb2BXNkfzrEVZ/yrV+OjS0QwWsMvIM5jpCxGK/h3A==
X-Received: by 2002:a05:620a:818e:b0:8bb:ac44:bd34 with SMTP id
 af79cd13be357-8bbac44e574mr1524349485a.4.1766006666356; 
 Wed, 17 Dec 2025 13:24:26 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8beeb5c3d2fsm30904385a.10.2025.12.17.13.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 13:24:26 -0800 (PST)
Date: Wed, 17 Dec 2025 16:24:25 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 28/51] tests/qtest/migration: Stop invoking
 migrate_incoming from hooks
Message-ID: <aUMfiWy3yPFRf-SF@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-29-farosas@suse.de>
 <aUMR699ZHbiF7_lh@x1.local> <87ecos2514.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ecos2514.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Dec 17, 2025 at 06:05:11PM -0300, Fabiano Rosas wrote:
> > E.g. test_mode_transfer_common() used different things to specify incoming
> > channels (cpr_channel, opts_target, connect_channels).  We should clean
> > them up at some point..
> 
> Yes, although it's a good test that the various ways of passing channels
> are working

Yes.  Said that, ideally IMHO we should only specify the channels, e.g. in
MigrationAddress format (for both main and cpr), then test code should be
able to convert it into either JSON (in form of "channels") or URIs.  I
recall we have had some discussion before on that.  We can leave that for
later.

-- 
Peter Xu


