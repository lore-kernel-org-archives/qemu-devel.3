Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E96C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9O8b-000294-WF; Wed, 23 Sep 2026 10:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9O8X-00024x-4W
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9O8V-0008Rn-O9
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790174390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Lap8L83OrynZd3UWczMwXAe2AAT0B/reteLCdO/cZGVzr9aktWqOBThKucCW0Z6uVAMGxL
 sZZaeoDu3bb6WVW9pX+xKNrKi9plMso8smXVXwrxK0rB5UaxjJqW1P7DOCOUsDziKn+aCh
 5PMYGnm3320kCojMmYJdNnsN7Vppuc4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-5bR3-ysaNtO29-Qg2LuCKQ-1; Wed, 23 Sep 2026 10:39:49 -0400
X-MC-Unique: 5bR3-ysaNtO29-Qg2LuCKQ-1
X-Mimecast-MFC-AGG-ID: 5bR3-ysaNtO29-Qg2LuCKQ_1790174388
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-486e90b59a6so630105f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790174388; x=1790779188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=BLRvDH3tG6tsUjA64o4cwBcqjLL5afIQ1Rr3Exm6UNwIm9TEF+qQH/BrlPbYO1NxYp
 gJKLj4Ux63Hg7B+k6Zi1D8Wy+4bfH9MnmzNt1HlVILCQVwNsV4tv5I9z/ipvAR2qTeax
 PE8JvtqwziYGJGzVfPYZq0QHyo+j36m20DY0dFeUXoEOQPGeDRVLBny2udA6R5KoIf1j
 v1seSus7bXXKSZtoHKPr0/DIbTmOdlsV5up8uj8jmvU+5TmtvvIo7kTC8HRfeNXMRpbo
 U9WW5u5ND0CmAmqfLMlLB5IxSHZ9jy9GWdwXhBH8vNfF3yws4jS3K+8xPQuaWDKFLiYe
 08yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790174388; x=1790779188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=xPk/v127N+UNHcyT8ynXbIFyeVi7vrNM6hn1WcyUME52TqsdZGDAifTKDKPJopcjMG
 dApZl82Bl+AAL1lvhkqYMpfRIxLeRWTS11M+5vM8YnQaxthggkZw3u2673pAmvgDR7VE
 GBrZCLUe5C9gi31k3khaGC7Toigees8FGg5jt0Tsd90kpi3Ud2xfPl518xu7BUTNIHcc
 DO8+NfHyWU/kBL3jy7y+jisa6BUSotsvT9TTr9CFXjyXoKO8XOOfcQe4kG/BwsNOvT+I
 u99K1x1I8XQpEPqkEaC8o+tAvz18SMzmO1E0Uq3zC8o3qtt2tl1sWLGWAc1HjbzzKzbW
 hOjA==
X-Gm-Message-State: AFuF++l15yopXb017i62MUbTVxhN4wKEyJkQNpOmKVmz6La6s7MZqq9/
 R87jXr4cCkIbq0CQ+EYbH1ITTkSXI8uqaemsN0zP/cOmV6oG0COvkNnEWKPoMSzMa69RUTQRgA4
 +eFE/kAQjl62Uz0vOdP7pn7VU5758inG5junPcXvfHpa0M5f/tTBYQslB
X-Gm-Gg: AYBFou3IjeHhye2Tvov8aCppp3ovZ0JJFg/w1+jE199coW/+QQoK458BZqBfXqirLnL
 jjk69rsvwWO3bXXNwiSFfsg8bwK8cjMLVVMXPyf/mf5cEY4gE5GaXSsfErwGUAl1118BFvLWYrz
 o30np1MXKzL60l+kQC34ctGi+B/j/D2d+ynmN8G2/DXTciI6mEmkgW+VvXDboz9GWU/7f3wDGHo
 paEgxQaIkGc/8XdTOj+qHeeWVYeGsJl2CnV9aur4wM2dRAnZevrSQNRLT08YIw0l3eMBEaGMaXB
 /GMxMJAytgzDrqJs22EhU9B+QHq8NSIJuHpl/BKBs5bBqS/y4J5kv+KzzxrWHZM2Bv88jkrhGgg
 vKqN6ZfN7QVtc69pyHWuTqE6fDaSObfXC+XeDKge8sExjJOrnZgGP3+88Lcf5ZJa3J6KJddOLfp
 AcIrMV
X-Received: by 2002:a05:600c:3b04:b0:49e:6778:c2bd with SMTP id
 5b1f17b1804b1-49fdee0a9e4mr38250365e9.6.1790174387860; 
 Wed, 23 Sep 2026 07:39:47 -0700 (PDT)
X-Received: by 2002:a05:600c:3b04:b0:49e:6778:c2bd with SMTP id
 5b1f17b1804b1-49fdee0a9e4mr38249955e9.6.1790174387241; 
 Wed, 23 Sep 2026 07:39:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1ccccfsm77893535e9.7.2026.09.23.07.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:39:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: qemu-devel@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>,
 Vulnerability Report <vr@darknavy.com>
Subject: Re: [PATCH] accel/kvm: protect kvm_resample_fd_list with a mutex
Date: Wed, 23 Sep 2026 16:39:42 +0200
Message-ID: <20260923143942.289538-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923004651.101197-1-mlevitsk@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


