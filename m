Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0272EECD997
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5pX-0006Kj-2L; Thu, 05 Feb 2026 15:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo5pV-0006K6-5L
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo5pT-0006r3-QZ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770322795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7nkyKodyjiQBwt+9Lq7So9I8zTucQy2tbsh6avw0aDc=;
 b=bgx9CE80AEiXbdDWFKu6M1fPI7bntv47hGA9eLWw55i+9K0eXgtFUbIPLBDbPtFJlyr5Er
 QJyKcv3ZzIh8lR6KlRpG9mqW9WUVyOuZqbQYWvl5CV8fQqrW+GgAW7m3iqb9o3BMYYtsvW
 ZiykNpqdwqcWbUOeN7icjpwG3dYilp4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-jZP9M9qfNa2RS1lcqEM15g-1; Thu, 05 Feb 2026 15:19:53 -0500
X-MC-Unique: jZP9M9qfNa2RS1lcqEM15g-1
X-Mimecast-MFC-AGG-ID: jZP9M9qfNa2RS1lcqEM15g_1770322793
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89473f5a755so49666486d6.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 12:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770322793; x=1770927593; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7nkyKodyjiQBwt+9Lq7So9I8zTucQy2tbsh6avw0aDc=;
 b=mnrH8p/v5BMBSKjIvXWH4HtXjCgU6DSPdzH3nzuTfo4tQ/c/Qkzc+yulUyB3eB0iYM
 5DpyYbLJ4PZKhdnzwXf1rz35LAgWwFwZkp3oICg+eF1vpppHr154Fp7EOcShinkpP2Ju
 5tMtSjUx1DdHomTUlr43QCxZSvsl10XY8zR83OilT3Nzu6AsFGU/5vZP61cQd3d3U4il
 3/Q5aGXgnzxB4rbT6somrnYeeYvQQfysoRUUwolwwgvt9LBSwY8n4iNsj2zv+ei0c7Z8
 nL0VFDJQjBi7tqc3eeF17Gy2qfKbNSNVOM3PggL6oVP9hRZgJWIOuSCAHK0NqaGqs05z
 8kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770322793; x=1770927593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nkyKodyjiQBwt+9Lq7So9I8zTucQy2tbsh6avw0aDc=;
 b=WUeGBvvIzSJGEIAT9/C1svDgT6DIjbasNd7dkcUXad7631v9eLo6BcXlHi2AQeIszS
 1UYcav5E0vXhYmQOJX9HKo8D5COLBKuu51kuVe7atspL5+7oqQ4TJZAhoVnbScVzZo4Q
 qgK9FxfOYJQsPYjVtSSiqxJMYvTf4Ib6E9vlddaeUMmKKXVoU36EgiPM7cjeB4qSJBPe
 wd+aZGR6GMIowR2H2ikYt8zbsO/wr/uxw36/gAT1cMb9S08nHv3wspzVCPorDZbUmY7A
 QtRquheVsZalhyX+SFT7DWxTtAVWLYW5Kgn6/JN0n/U1N/+qKbEZbwn/5YcYPP39Bd0t
 I31Q==
X-Gm-Message-State: AOJu0YxohXvx0c0xC5lBdnvu4zAiVsXn3EeTXD0Wo85ngPSSgfbbNKrc
 bStP1ARCgIUF6DoMG9Jwa453dhaCqYAn+68sy16/6ICPAkQWaXfo1kk1IJwwPNZmWy7rLUE/iyw
 neDg/I2GPk5rK2DaKGlsf6uATktydQuojmgxG0jrojNlRYgpmjhanV3QB
X-Gm-Gg: AZuq6aI48H61cfntauiPeWzxOIyhsOl51WkrLMWnbZng1JIrMwFmKiop1KsjxlBnt4B
 PAZ5XjBKmjZ7jivHP01qYc9j71WtuC80twO09o8U7hJzJkPNGIQKMrmwl+nYM2gO4ywiyQnBlsO
 NYuJfDxqW34UMHfRhXE+WR1gnhS+oUW/JMmdjPDNjOjfEG4jNvv3gax0Et810lDPhtw4/0et/PD
 9Sp8pJ6kO1JjGyx6WYICK43J3B/4dsxQU40j5w4ofCfG0h8Qh93rEz66arCKusSwIcJtrTjpRbc
 JdqQPBYu/A07ufuZZ+MIyzo8Lbw/XFBNIW+3tgtFK/2mPRieEEe2eHZHtM/wmwQma3FE7O4BzwU
 mE6w=
X-Received: by 2002:a05:6214:21c4:b0:882:8b19:da02 with SMTP id
 6a1803df08f44-8953cb7d6d0mr4836186d6.50.1770322793037; 
 Thu, 05 Feb 2026 12:19:53 -0800 (PST)
X-Received: by 2002:a05:6214:21c4:b0:882:8b19:da02 with SMTP id
 6a1803df08f44-8953cb7d6d0mr4835816d6.50.1770322792501; 
 Thu, 05 Feb 2026 12:19:52 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c056e78sm3034516d6.39.2026.02.05.12.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 12:19:52 -0800 (PST)
Date: Thu, 5 Feb 2026 15:19:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com
Subject: Re: [PATCH v2 1/9] migration/options.c: Don't export
 migrate_tls_opts_free
Message-ID: <aYT7Z-UjzPoMXAv2@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
 <20260202224101.20568-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260202224101.20568-2-farosas@suse.de>
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

On Mon, Feb 02, 2026 at 07:40:53PM -0300, Fabiano Rosas wrote:
> The migrate_tls_opts_free function was never used outside
> options.c. Make it static.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


