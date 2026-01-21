Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC57C4450D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 12:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viXTR-0001Pw-RR; Wed, 21 Jan 2026 07:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1viXQq-0007HD-Dj
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:35:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1viXQn-0004Qq-UE
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:35:31 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dx3YV4pnHzHnGdH;
 Wed, 21 Jan 2026 20:34:54 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 605424056B;
 Wed, 21 Jan 2026 20:35:28 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 12:35:27 +0000
Date: Wed, 21 Jan 2026 12:35:26 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Michael S Tsirkin <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Cleber Rosa
 <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 05/13] scripts/qmp_helper: fix raw_data logic
Message-ID: <20260121123526.00004218@huawei.com>
In-Reply-To: <dbfa5c4c60c9f27a3f13ed9de7d510fa99ea536e.1768993993.git.mchehab+huawei@kernel.org>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <dbfa5c4c60c9f27a3f13ed9de7d510fa99ea536e.1768993993.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 21 Jan 2026 12:25:13 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> According with UEFI 6.4 spec Table 18.11 Generic Error Status Block:
> 
> Raw Data Offset:	Offset in bytes from the beginning of the
> 			Error Status Block to raw error data.
> 			The raw data must follow any Generic Error
> 			Data Entries.
> 
> Data Length:		Length in bytes of the generic error data.
> 
> So, basically, we have:
> 
> 	+----------+                 /
> 	| GEBS     |                 |
> 	+----------+   /             |
>         | GEDE     |   |             |

Mix of tabs and spaces it seems.  Nice to tidy that up.

>         | header   |   |             +--> raw data
> 	+----------+   +--> data     |    offset
>         | GEDE     |   |    length   |
>         | payload  |   |             |
> 	+----------+   /             /
> 	| Raw data |
> 	+----------+
> 
> where:
> 
> - raw data offset is relative to the beginning of GEBS;
> - data length is only for GEDE header and payload.
> 
> Fix the code to handle it the expected way.

Maybe say what it did previously?

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Code seems fine to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  scripts/qmp_helper.py | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
> index 51c8ad92a39d..40059cd105f6 100755
> --- a/scripts/qmp_helper.py
> +++ b/scripts/qmp_helper.py
> @@ -411,6 +411,7 @@ def _connect(self):
>          "simulated":    util.bit(2),
>      }
>  
> +    GENERIC_ERROR_STATUS_SIZE = 20
>      GENERIC_DATA_SIZE = 72
>  
>      def argparse(parser):
> @@ -551,7 +552,7 @@ def send_cper_raw(self, cper_data):
>  
>          return False
>  
> -    def get_gede(self, notif_type, cper_length):
> +    def get_gede(self, notif_type, payload_length):
>          """
>          Return a Generic Error Data Entry bytearray
>          """
> @@ -563,22 +564,27 @@ def get_gede(self, notif_type, cper_length):
>          util.data_add(gede, 0x300, 2)
>          util.data_add(gede, self.validation_bits, 1)
>          util.data_add(gede, self.flags, 1)
> -        util.data_add(gede, cper_length, 4)
> +        util.data_add(gede, payload_length, 4)
>          gede.extend(self.fru_id)
>          gede.extend(self.fru_text)
>          gede.extend(self.timestamp)
>  
>          return gede
>  
> -    def get_gebs(self, data_length):
> +    def get_gebs(self, payload_length):
>          """
>          Return a Generic Error Status Block bytearray
>          """
>  
> +        data_length = payload_length
> +        data_length += self.GENERIC_DATA_SIZE
> +
>          gebs = bytearray()
>  
>          if self.raw_data:
> -            raw_data_offset = len(gebs)
> +            raw_data_offset = payload_length
> +            raw_data_offset += self.GENERIC_ERROR_STATUS_SIZE
> +            raw_data_offset += self.GENERIC_DATA_SIZE
>          else:
>              raw_data_offset = 0
>  
> @@ -617,8 +623,7 @@ def send_cper(self, notif_type, payload,
>          if raw_data:
>              self.raw_data = raw_data
>  
> -        cper_length = len(payload)
> -        data_length = cper_length + len(self.raw_data) + self.GENERIC_DATA_SIZE
> +        payload_length = len(payload)
>  
>          if gede and len(gede) != 72:
>              print(f"Invalid Generic Error Data Entry length: {len(gede)}. Ignoring it")
> @@ -629,16 +634,16 @@ def send_cper(self, notif_type, payload,
>              gebs = None
>  
>          if not gede:
> -            gede = self.get_gede(notif_type, cper_length)
> +            gede = self.get_gede(notif_type, payload_length)
>  
>          if not gebs:
> -            gebs = self.get_gebs(data_length)
> +            gebs = self.get_gebs(payload_length)
>  
>          cper_data = bytearray()
>          cper_data.extend(gebs)
>          cper_data.extend(gede)
> -        cper_data.extend(bytearray(self.raw_data))
>          cper_data.extend(bytearray(payload))
> +        cper_data.extend(bytearray(self.raw_data))
>  
>          if self.debug:
>              print(f"GUID: {notif_type}")


