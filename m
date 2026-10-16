Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F2DCCA46B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeW5-0004md-M7; Fri, 16 Oct 2026 05:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHeVw-0004iY-KU
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHeVv-0007ex-5I
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792143970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tC771wZvpbimVC0SvyehazSdCFQ55l6h+G6jQXFkKPA=;
 b=FaOfZE221EP0bRhI0r+zpquHr2dOlpTHbKiztJ11iiF5PKQFAsr6NeFHMGdqKLE88Q/MNn
 RQyXItmEG2sEQ0mP9O/CoUa769ai17bPovzK9s6RBbLe9MMMmfZLtFPJC4tEWkABui+PSX
 RbxjT9ht8+kduKXgBhyAdJOJoXTIkcU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-6S0PkSPBNNmL9KWLzsq0xw-1; Fri,
 16 Oct 2026 09:46:03 +0000
X-MC-Unique: 6S0PkSPBNNmL9KWLzsq0xw-1
X-Mimecast-MFC-AGG-ID: 6S0PkSPBNNmL9KWLzsq0xw_1792143962
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 142191944D3A; Fri, 16 Oct 2026 09:46:02 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5EC661956043; Fri, 16 Oct 2026 09:46:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/19] hw/core/sysemu-cpu-ops: add get_dump_info
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 anjo@rev.ng
In-Reply-To: <20261015213236.157767-2-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <20261015213236.157767-2-pierrick.bouvier@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 13:45:51 +0400
Message-Id: <179214395192.1157317.14342665925366918420.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=766;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZurmzMgPBv1ICeNSY0OvDz6B1PqXGctHozqZh2keDQM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0fJS4RZwzgGnRYru4s8zSrWDoBQYp+87jB2un
 Vld1RZaVn+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatHyUgAKCRDa6OEJdZac
 5ZdOD/0cj1y67/zC1r9SHdr7BmpHhwWAYh/xpIhbytJai/OfL6lBbrW6E4/0fqUU9V6Q6Qh77zg
 xhg/VWtb1GjIK001qnpDM+0VeE/TTx57T6apJI8M60du7TWkMiCCF9HUGSD2d7oCoDB5bNsZmJo
 xk8zuKWB1CTIogjRdP9A7iXB053TT23t+WydcU8iY6f0JayGDMEOBWg7QYmli9ZjYa7fKaV0iBg
 qL+pXw/H3RNlkcGEyXKMiU8WyemwmLDVj2DfewkVvLfSolA9/A6yTWnzGBySfHWNW7h/BX+jdG7
 Tlom/PfMAV/72+w0JhmFMQXCow5X6bDNIj/nzHKPVZGH5TAR6iBJ8V/oTj4tQ12oxB/n6uzQ0c5
 K4DDgiLX14xJFRuMduUYBGdssIbtiisXJ0e2u/PVCO0rtjlXTiKeWbw4JTQHDPPrr10o8+urc1O
 8yf+9+abnKYEjibw0/LPWnuVRImO7Wztf8UGJ0CODJB1eLdl6iApifHQ2vxM/jFvII6KtV0Uxc/
 NVZIixBkkW1kyl4g3tor8YFCp/FdCPz27s2xHwb3y2ComKHi0V7zxiKzVJochSMBcvVfUdY5LoR
 wIM+JasfQ2ilCgMxA8K+OSonNSQcdUz/BWv3qN+Q/ZXEFaXqgZpvRG1q6NVLD32kqsxBCpG7iFk
 DFDat9EzDiiEJ/w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> This allows a specific cpu to declare its implementation of
> get_dump_info, needed by dump.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Message-ID: <20261015213236.157767-2-pierrick.bouvier@oss.qualcomm.com>
>
> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
> index d125540262d2..0b6bb42dc2cb 100644
> --- a/include/hw/core/sysemu-cpu-ops.h
> +++ b/include/hw/core/sysemu-cpu-ops.h
> @@ -11,6 +11,7 @@
>  #define SYSTEM_CPU_OPS_H
>  
>  #include "hw/core/cpu.h"
> +#include "system/dump-arch.h"

Instead of including this header in a bunch of places, why not add
typedef struct ArchDumpInfo ArchDumpInfo in qemu/typedefs?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


