Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB124CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkrW-0003YF-Ts; Wed, 20 May 2026 13:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPkrV-0003Xq-MQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPkrU-0007O3-Aj
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779298659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e5dfOKoai6mQlil7/2UkIx/xEOK/weQPHPzqX6vsBB8=;
 b=FpxaMZCNPT3ux41vBVNCBO6PAoVNVLvL0LNiO35M37l2cdiitjk/bQjMW5biY2+50Fq8ZA
 4PRYgM81VVkCYGiAFqmQY0vkE5v4fZaxe8fdFurWb9v3mSPxcb6ejp3rokV6rofKfnwezt
 7vcLmnlyOsI7VFTjpSFLQW+xotj0veg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-tbVC562sOb6G_JMEJzP5nA-1; Wed, 20 May 2026 13:37:37 -0400
X-MC-Unique: tbVC562sOb6G_JMEJzP5nA-1
X-Mimecast-MFC-AGG-ID: tbVC562sOb6G_JMEJzP5nA_1779298657
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ca1e0f5a4bso149875576d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779298657; x=1779903457; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e5dfOKoai6mQlil7/2UkIx/xEOK/weQPHPzqX6vsBB8=;
 b=X0r2O0XWrhcEIFUxmNgnWF/Qi0HjyTIFfp/jY+MjLL3s2AjnobslPNjIh1p6uDDOLD
 D7H2X3DvGl9QDWLOT8+uiIqSt0YSua+1kE3liQLY7M/3zCooWPDrhA9t340sUyt5grlU
 rnAAV6ak5r8vLzHPYqYKpCC6KXT8ue+i/nF6RYvp3Aqdx3aIc6uAUmm5kFoQtab8NFpG
 geZFa/8f9xv27DPq4jzq6PHkPr+bkSzc/eOf1HzLlBAwVH2ySn/4vyLwPacitt8VK3kC
 ns/wh3GFiJUmqMpvRJSmpH92KO8GA1HLaIzFOzYCN+jh2TsK9GY98qz+e8YDZafXRtEH
 vTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779298657; x=1779903457;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e5dfOKoai6mQlil7/2UkIx/xEOK/weQPHPzqX6vsBB8=;
 b=oIV6qkdcTkgOb3bUGNzHi0X9HZTXsEaJakKNpf3LHqLV1rgkcv9Aoc7n8f9lssGC4z
 b7lZu6+hL53jCFcY4gTmm6W2tD3aAnkcHZB9bcwu7Rj5oerPKGlbn3qU4fLzmUDtdXD5
 EmuM76HqHdnBTC02bGJxBvxM4lRoL3u57aLVpqIG+XSZLO+P1BNRkhtJ70e49f6VNiX7
 mXCxey5HQKM4IN2K7RjqB6s57Cm68ntOSbqeWtTJKmYbKI5zyFfiwhSvYv+qAMWC/VoV
 56W5hkYkP+ZL5QPafUUI7KKQd5zx6k+pG1USKFRgvMhFd8MRfLD5pI0SbItdKKRb8w2E
 vi3w==
X-Gm-Message-State: AOJu0YxnImDe1exHsU0mlZBH4bMTEHVrlEqfuQkTVKLv0UJN5Adut0xM
 SyMDAsmpNny2Lv5WsHtEHxy+GWK6nTz7ejzczPSdtYGcqxz3j1PZWJGq1CNaS0VdGccxU6j0Ti5
 pYV1VEMsAyuAu0vlKB7iiTVRxACGgPGylxR3QL9+ctuJOSmbzIhATPTEXdeddt1jA
X-Gm-Gg: Acq92OF+Fzdnyg6FiyL5g8T43AFIsXkPc0rWr0UX1BbbZnQYBrtpwlv5xNsn2PtzUWO
 ADK5XxLCMTpysR+7E5wNC5QLq/KShHq/+anpKcrb67iY1Dm95kWM/s3VlgZSQix49XT2thC+A2v
 W2/XNIHzA7k1d1q3/XqqFwP7jxFxDtlxp/84imji8qJVsCvNLPLaO+gPsasVIO70LEfaWk0kgWm
 h95vRNXFP1I/SbWLYyPbigyeIovvYfY1xfTPn14zF6hvUUpSMLwrdfP8W96azGf4DtJVsjsW6Kl
 3fqko2+9B7WBU/QQfkP6+lhuuNQwWK7oVmIiTv8mtrUdG4qWBIokx0Vx2PnSmELSZKosqQYOeOl
 dn4s0wse/vfVrT23Q0G3lpIB6kCOZlfXG9oyNiXksYnMqARiPW0FNapLzWA==
X-Received: by 2002:a05:6214:11aa:b0:8bd:de6d:c349 with SMTP id
 6a1803df08f44-8ca0f67c4ecmr301220246d6.30.1779298656745; 
 Wed, 20 May 2026 10:37:36 -0700 (PDT)
X-Received: by 2002:a05:6214:11aa:b0:8bd:de6d:c349 with SMTP id
 6a1803df08f44-8ca0f67c4ecmr301219846d6.30.1779298656158; 
 Wed, 20 May 2026 10:37:36 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca3619c29asm127557396d6.34.2026.05.20.10.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:37:35 -0700 (PDT)
Date: Wed, 20 May 2026 13:37:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 13/15] tests/qtest/migration: Use defer in dirty_limit
 test
Message-ID: <ag3xXsCMnQnaWAp4@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-14-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-14-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 05, 2026 at 01:09:12PM -0300, Fabiano Rosas wrote:
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


