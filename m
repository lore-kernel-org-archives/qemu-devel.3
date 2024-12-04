Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F85E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIkvk-0001mS-Kw; Wed, 04 Dec 2024 03:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tIkva-0001l2-Md
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:40:12 -0500
Received: from 2.mo552.mail-out.ovh.net ([178.33.105.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tIkvW-0006Lo-ER
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:40:10 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.176.9])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4Y39tz3fhmz1HJM;
 Wed,  4 Dec 2024 08:39:55 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 09:39:49 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S0022a5cab01-1513-406d-a95e-7b3f38a5f720,
 62840BB153752879C0E2448B5A3616A023B66188) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Wed, 4 Dec 2024 09:39:37 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Mads
 Ynddal" <mads@ynddal.dk>
Subject: Re: [PATCH] 9pfs: improve v9fs_walk() tracing
Message-ID: <20241204093937.7bd96a32@bahia>
In-Reply-To: <E1tIPPo-006ldP-Uk@kylie.crudebyte.com>
References: <E1tIPPo-006ldP-Uk@kylie.crudebyte.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 1f53c24b-a277-4b50-babd-95ed81d0206d
X-Ovh-Tracer-Id: 1538823698303523296
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggdduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeekjedtveegkeeileffvdetvddvgedtudduiefghffhgfdvhfegjeetkeehfeeknecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdekpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrughsseihnhguuggrlhdrughkpdfovfetjfhoshhtpehmohehhedvmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=2HX4Hsp9c1thwTHSBI9xJk0JYQAHlAxJhUnDg4nEd1Y=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1733301595; v=1;
 b=dx7xrAd/WKNJiYMDJIzdIWbTJE8e97KFp5Dp3K4f38l3zgpr57RtIEpeLXy2h9ZxECXJRevN
 KQep4UqbNDx2aGvkoSunch7HEFfhQ1CbVncL54OBT43gkEKNTlw4sQcH4NDn/NmuL2hsQzMjaTX
 IALzAZjyFcOglt+bnu0VLiXeRDXzLr7r43xI1JAesXK4lk2JmlaMA5LrVVEjWFLOchuRvJr05hq
 nEA4peqOgMbI64FTbf5OXps+5SCrxqWe0orG4G/CdCXtd/pS3N8X6YRah1I14N/bnbvp68Ms6vU
 /8UNPNP9VmT316wCxXyzWY0MrE0CVIYwGiHMD7nKpv3bg==
Received-SPF: pass client-ip=178.33.105.233; envelope-from=groug@kaod.org;
 helo=2.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 3 Dec 2024 10:14:28 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> 'Twalk' is the most important request type in the 9p protocol to look out
> for when debugging 9p communication. That's because it is the only part
> of the 9p protocol which actually deals with human-readable path names,
> whereas all other 9p request types work on numeric file IDs (FIDs) only.
> 
> Improve tracing of 'Twalk' requests, e.g. let's say client wanted to walk
> to "/home/bob/src", then improve trace output from:
> 
>   v9fs_walk tag 0 id 110 fid 0 newfid 1 nwnames=3
> 
> to:
> 
>   v9fs_walk tag=0 id=110 fid=0 newfid=1 nwnames=3 wnames={home, bob, src}
> 
> To achieve this, add a new helper function trace_v9fs_walk_wnames() which
> converts the received V9fsString array of individual path elements into a
> comma-separated string presentation for being passed to the tracing system.
> As this conversion is somewhat expensive, this new helper function returns
> immediately if tracing of event 'v9fs_walk' is currently not enabled.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  CCing tracing maintainers in case they have better ideas how to do this.
> 
>  hw/9pfs/9p.c         | 42 +++++++++++++++++++++++++++++++++++++-----
>  hw/9pfs/trace-events |  2 +-
>  2 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 578517739a..c08e7e492b 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1774,6 +1774,30 @@ static bool same_stat_id(const struct stat *a, const struct stat *b)
>      return a->st_dev == b->st_dev && a->st_ino == b->st_ino;
>  }
>  
> +/*
> + * Returns a (newly allocated) comma-separated string presentation of the
> + * passed array for logging (tracing) purpose for trace event "v9fs_walk" only.
> + * If tracing for that event is disabled, it immediately returns NULL instead.
> + *
> + * It is caller's responsibility to free the returned string.
> + */
> +static char *trace_v9fs_walk_wnames(V9fsString *wnames, size_t nwnames)
> +{
> +    g_autofree char **arr = NULL;
> +
> +    if (trace_event_get_state(TRACE_V9FS_WALK) &&
> +        qemu_loglevel_mask(LOG_TRACE))
> +    {
> +        arr = g_malloc0_n(nwnames + 1, sizeof(char *));
> +        for (size_t i = 0; i < nwnames; ++i) {
> +            arr[i] = wnames[i].data;
> +        }
> +        return g_strjoinv(", ", arr);
> +    }
> +
> +    return NULL;
> +}
> +
>  static void coroutine_fn v9fs_walk(void *opaque)
>  {
>      int name_idx, nwalked;
> @@ -1787,6 +1811,7 @@ static void coroutine_fn v9fs_walk(void *opaque)
>      size_t offset = 7;
>      int32_t fid, newfid;
>      P9ARRAY_REF(V9fsString) wnames = NULL;
> +    g_autofree char *trace_wnames = NULL;
>      V9fsFidState *fidp;
>      V9fsFidState *newfidp = NULL;
>      V9fsPDU *pdu = opaque;
> @@ -1800,11 +1825,9 @@ static void coroutine_fn v9fs_walk(void *opaque)
>      }
>      offset += err;
>  
> -    trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames);
> -
>      if (nwnames > P9_MAXWELEM) {
>          err = -EINVAL;
> -        goto out_nofid;
> +        goto out_nofid_nownames;
>      }
>      if (nwnames) {
>          P9ARRAY_NEW(V9fsString, wnames, nwnames);
> @@ -1814,15 +1837,20 @@ static void coroutine_fn v9fs_walk(void *opaque)
>          for (i = 0; i < nwnames; i++) {
>              err = pdu_unmarshal(pdu, offset, "s", &wnames[i]);
>              if (err < 0) {
> -                goto out_nofid;
> +                goto out_nofid_nownames;
>              }
>              if (name_is_illegal(wnames[i].data)) {
>                  err = -ENOENT;
> -                goto out_nofid;
> +                goto out_nofid_nownames;
>              }
>              offset += err;
>          }
> +        trace_wnames = trace_v9fs_walk_wnames(wnames, nwnames);
> +        trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, trace_wnames);
> +    } else {
> +        trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, "");
>      }
> +
>      fidp = get_fid(pdu, fid);
>      if (fidp == NULL) {
>          err = -ENOENT;
> @@ -1957,7 +1985,11 @@ out:
>      }
>      v9fs_path_free(&dpath);
>      v9fs_path_free(&path);
> +    goto out_pdu_complete;
> +out_nofid_nownames:
> +    trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, "<?>");
>  out_nofid:
> +out_pdu_complete:
>      pdu_complete(pdu, err);
>  }
>  
> diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
> index a12e55c165..ed9f4e7209 100644
> --- a/hw/9pfs/trace-events
> +++ b/hw/9pfs/trace-events
> @@ -11,7 +11,7 @@ v9fs_stat(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d fid %d"
>  v9fs_stat_return(uint16_t tag, uint8_t id, int32_t mode, int32_t atime, int32_t mtime, int64_t length) "tag %d id %d stat={mode %d atime %d mtime %d length %"PRId64"}"
>  v9fs_getattr(uint16_t tag, uint8_t id, int32_t fid, uint64_t request_mask) "tag %d id %d fid %d request_mask %"PRIu64
>  v9fs_getattr_return(uint16_t tag, uint8_t id, uint64_t result_mask, uint32_t mode, uint32_t uid, uint32_t gid) "tag %d id %d getattr={result_mask %"PRId64" mode %u uid %u gid %u}"
> -v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_t nwnames) "tag %d id %d fid %d newfid %d nwnames %d"
> +v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_t nwnames, const char* wnames) "tag=%d id=%d fid=%d newfid=%d nwnames=%d wnames={%s}"
>  v9fs_walk_return(uint16_t tag, uint8_t id, uint16_t nwnames, void* qids) "tag %d id %d nwnames %d qids %p"
>  v9fs_open(uint16_t tag, uint8_t id, int32_t fid, int32_t mode) "tag %d id %d fid %d mode %d"
>  v9fs_open_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path, int iounit) "tag %u id %u qid={type %u version %u path %"PRIu64"} iounit %d"



-- 
Greg

