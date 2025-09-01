Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A92ECA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4aq-0005BJ-Do; Mon, 01 Sep 2025 09:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4aM-00053o-Qg
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4aG-0001Zi-Jf
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756733306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h1iZemTpxf18xAmBDEbSPl4vsteqZJrkhcA4XAxcmjM=;
 b=Fs1KGJ4lqfWeBm8POdu6R9dZuOd+sINKJhveD0UzvT93VKDRTw3ieEZIqNdhXPcbDXYfMw
 iYzYYElzz+4UBhXoKb6fYGR0bZRJQqzPL1VMJB4RwHHix+6bpRnghaUwqVc8eHTw3SzyyM
 6nH5NQ+YwMnmuncx71g1bZSxicE0FFs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-i2WBU7cqOZWqCGnRN8n2-g-1; Mon, 01 Sep 2025 09:22:32 -0400
X-MC-Unique: i2WBU7cqOZWqCGnRN8n2-g-1
X-Mimecast-MFC-AGG-ID: i2WBU7cqOZWqCGnRN8n2-g_1756732952
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-70dfcc58976so69324126d6.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756732951; x=1757337751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1iZemTpxf18xAmBDEbSPl4vsteqZJrkhcA4XAxcmjM=;
 b=fu9DG1ME8rHj7a5mXkyvhQoxg9SSS5wS3xn2bxflNCzwiCUpGHPUUHLfDbsNRer50V
 SoySOJKNqUc5M3A0eUA9vBVNepyaDc98PzbKDpVTuhAEb3kvOzlUtagHdAxuGvb9VEGx
 NE04WEkpJlatBm9aqKSw5lXv9xI5T3ahCzMNSCAkg+i11UnhqgnjmdQVr4QVuLwz0X3n
 F+hlGXVJ45YLItsMfjCvBc77dZRWSCkRcjy+XXTCFlD+jsn78KZ/PuPMABdBRxEfBgna
 BZaM2PbbKIb1Cbg5A6uUzhItLIYaUoRKfgv9TuARrcxyxqoAZNZPu6B6BoCPgWLdKdSh
 v91Q==
X-Gm-Message-State: AOJu0Ywjr156cYGDj8toedfiicBMsw3dvk1RxdMTt5ZDtf5Kr0//jujR
 Y3uJNEtUk5uJOmdoOFqWjyDmXT/vbrdg4VWVwRqVux1PtDZoU6Ttt8Ek3Zpb6fVLfGOYSYLggKn
 Q+1jbsX2XadhyxNAd9xG7tnpJfFGAdgct9L4ELIGvuu9HOSHNH7HptWy5CSge2Ez1
X-Gm-Gg: ASbGncs+dr21xxkK8f3Zn/8MM2O7PLvhsAHWInZHLBDhxaQ9kfGRpNMUn3K4LoGGPim
 f2JW02DVirju7weSWyZDe24D/ZGfL8al0xbHpAQ5LwRyBTvSA5+ZXoCzNDLOrViFeA+EqjZ9oIX
 vHKDaMxMyZkF8iMKnx2u1nyoyQhFYRsIkS2nw1EpxzmyB12FL1tf3wbfucUCSCTRu4k6g8WU3v9
 vJybAQ5i2IoPqBCJpBDeIJQ6w2ejNa2aWeK5m/mbH+BhQ0lF9VAVxJOWDWOlS8xrnOKhXYv66sX
 BN3couxxi+LcfKV5r0rTKPVxrN/fXw==
X-Received: by 2002:ad4:5ce6:0:b0:71e:a083:f1b4 with SMTP id
 6a1803df08f44-71ea0842731mr9566826d6.39.1756732951481; 
 Mon, 01 Sep 2025 06:22:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPhTcRxUOyk7krSxAntL2pRJZbIS15mFK9D28CMMQ7+tF7TitGQMabwimej2hHRxtSQWKJdw==
X-Received: by 2002:ad4:5ce6:0:b0:71e:a083:f1b4 with SMTP id
 6a1803df08f44-71ea0842731mr9566436d6.39.1756732951102; 
 Mon, 01 Sep 2025 06:22:31 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70fb289f518sm39701686d6.56.2025.09.01.06.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:22:30 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:22:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, richard.henderson@linaro.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: Re: [PATCH 13/18] cpus: remove TCG-ism from cpu_exit()
Message-ID: <20250901152227.24a59620@fedora>
In-Reply-To: <20250829153115.1590048-9-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-9-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 29 Aug 2025 17:31:10 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Now that TCG has its own kick function, make cpu_exit() do the right kick
> for all accelerators.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/core/cpu-common.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index ca00accd162..3fa9fa82228 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -76,9 +76,7 @@ void cpu_exit(CPUState *cpu)
>  {
>      /* Ensure cpu_exec will see the reason why the exit request was set.=
  */
>      qatomic_store_release(&cpu->exit_request, true);
> -    /* Ensure cpu_exec will see the exit request after TCG has exited.  =
*/
> -    smp_wmb();
> -    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
> +    qemu_cpu_kick(cpu);
>  }
> =20
>  static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray *buf, =
int reg)


