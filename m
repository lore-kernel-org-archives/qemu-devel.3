Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58297C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8zUb-0007Oj-Rh; Tue, 22 Sep 2026 08:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1x8tkq-0005vE-HD
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 02:13:25 -0400
Received: from smtpout7.mo536.mail-out.ovh.net ([51.210.91.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1x8tkj-00045u-RJ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 02:13:22 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hpqXM4fPqz87r7;
 Tue, 22 Sep 2026 06:13:07 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <qemu_oss@crudebyte.com>; Tue, 22 Sep 2026 06:13:07 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.96.215])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hpqXM3n6Wz1xpZ; Tue, 22 Sep 2026 06:13:07 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: groug@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 1FD381924077; Tue, 22 Sep 2026 06:13:07 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003b194b455-6a76-4955-b105-83e7c28b90ab,
 E5BDE0A46C035AFE328FEA0F3CAD2DA76BA1653B) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Tue, 22 Sep 2026 08:13:01 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/9pfs: mutate FID path from main thread only
 (CVE-2026-93834)
Message-ID: <20260922081301.244e5524@bahia>
In-Reply-To: <E1x8d3N-003M3F-Pz@kylie.crudebyte.com>
References: <E1x8d3N-003M3F-Pz@kylie.crudebyte.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 2049982256527095013
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFsYbhAYyuA6JQo3Vpz3m7VDWBNml/1YwmitVUlatwtR3kRujDYa4B9T6+Eou6f3+5L7iGTxqawsnLimUTFnnsu2vFgZhOZWQBR7faRagVCwtlH5V61iK2u+p1dInTWzkCBCDhD5M8ajgRV8q+j4lU2QD6h1r+AKq2Nc+QC3/NXxRFq0NOgdoSDZl7ZzCBuha4NKYJwNsyzzRcO8CAj3Kn1MZG+2W0O+SLW3/PTjHZArxSFydTlo3eKXRtDI9/JCnkD43AJJnp5acX2HlDc3CxCehhrvs/64OZLOhKIRwSZD2aVmsjtyclX8LXWQ3ccMdY8FJ0snfTG0ap7L+EqXuxoVFQ8cpgaDdvTjRIaeQhx5Lvu7uceFmcFFTUbanWHf7SfR6BzQH2FW6Nb8eJOTLrazIlHaIxoouJjh/8WsUmQe5lhh46z8mJAVjfVRtScgSFyLee7OnvYUquusn9k154x09zbPWuBTq21RvkcmUAT6qRPbue9YeMyQFlUAqXuUA2KzJbjbTExDVcBpL8LF4mAv1uYWld4taQc/XrywXZgHvqn4Q+pVVviYz6TsQk/JgvCaGtoJ/kGff+af6VeXM5weBFJixvdLPyjAUkSqMpLyb9qukwq5WeP4GDcV0vcZrCWXtm1xsqpavtP2o6ASH/6AJnye+aJbDWckAejXLJavA
DKIM-Signature: a=rsa-sha256; bh=B9pSEIw8Ml37OrfF3mgxBCOyD3y93IV3SVSDbAH1IVU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1790057587; v=1;
 b=FQ9309xqH1dSIlirnHAG27F+9pUydFZickkVJxABrB8hTRLOabrYFzqndVQW0R/5SbBFrtpi
 f7/g0g/vA4Y9zM7NDIn++QGGuzcLORsSB+dJJ0Q4k0aIijGbvbkGk4+QrbGbN1XDJ6o48KC1J2k
 d6dB2oFNB+d4sQyfGjCXFwNhLC/pPVm58hAl/PdFm5Eh5PBSYitXt8ZCSxZhGMzvF0LUbqd/x6p
 7w4tW3k4vGgIfK47QLx2ys7YPD19j6Tn3ub+/lUppTO8b4aJNq98SY5wIR9nvzJ5RtXljMERExm
 iBnh3Evx+arcYRAKsUnDmCVcZRCC2Fd1LjOqnk8I79+RQ==
Received-SPF: pass client-ip=51.210.91.16; envelope-from=groug@kaod.org;
 helo=smtpout7.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:20:58 -0400
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

On Mon, 21 Sep 2026 14:18:58 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> v9fs_co_open2() is the only code that mutates a FID path from a worker
> thread: inside its v9fs_co_run_in_worker() block it frees fidp->path
> and copies in the new path under the held FID path write lock.
> 
> Every other FID path mutation in the 9p codebase happens on the main
> thread, so main thread readers (v9fs_walk(), v9fs_xattrwalk(),
> v9fs_stat(), v9fs_co_name_to_path()) rely on the same (main) thread
> atomicity and don't take the path read lock themselves on main thread.
> 
> Fix this by making the worker thread block in v9fs_co_open2() read-only
> with respect to the FID: render the new path into the local 'path'
> variable only and copy it to fidp->path after the worker block returned
> back to the main thread and still under the held write lock of the FID,
> like every other FID path mutation does.
> 
> Fixes: 02cb7f3a25 ("hw/9pfs: Use read-write lock for protecting fid path.")

Wow, it's a long standing issue ! ;-)

> Fixes: CVE-2026-93834

Cannot find it... embargoed ?

> Reported-by: Milad Nasr <https://gitlab.com/sirkhezr>
> Suggested-by: Milad Nasr <https://gitlab.com/sirkhezr>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4491

Cannot find that either...

> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

but fix looks good.

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/cofile.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
> index 6e775c8e41..27fe5bfb20 100644
> --- a/hw/9pfs/cofile.c
> +++ b/hw/9pfs/cofile.c
> @@ -144,10 +144,11 @@ int coroutine_fn v9fs_co_open2(V9fsPDU *pdu, V9fsFidState *fidp,
>      cred.fc_mode = mode & 07777;
>      cred.fc_uid = fidp->uid;
>      cred.fc_gid = gid;
> +    v9fs_path_init(&path);
>      /*
>       * Hold the directory fid lock so that directory path name
> -     * don't change. Take the write lock to be sure this fid
> -     * cannot be used by another operation.
> +     * don't change. Take the write lock since the fid path is
> +     * mutated below on success.
>       */
>      v9fs_path_write_lock(s);
>      v9fs_co_run_in_worker(
> @@ -157,23 +158,30 @@ int coroutine_fn v9fs_co_open2(V9fsPDU *pdu, V9fsFidState *fidp,
>              if (err < 0) {
>                  err = -errno;
>              } else {
> -                v9fs_path_init(&path);
>                  err = v9fs_name_to_path(s, &fidp->path, name->data, &path);
>                  if (!err) {
>                      err = s->ops->lstat(&s->ctx, &path, stbuf);
>                      if (err < 0) {
>                          err = -errno;
>                          s->ops->close(&s->ctx, &fidp->fs);
> -                    } else {
> -                        v9fs_path_copy(&fidp->path, &path);
>                      }
>                  } else {
>                      s->ops->close(&s->ctx, &fidp->fs);
>                  }
> -                v9fs_path_free(&path);
>              }
>          });
> +    /*
> +     * The fid path must not be mutated from the worker thread: other
> +     * requests may access the same fid on the main thread, and the main
> +     * thread never takes the path lock for reads. Mutate the new path
> +     * here, on the main thread and still under the held write lock, like
> +     * every other mutation of a fid path.
> +     */
> +    if (!err) {
> +        v9fs_path_copy(&fidp->path, &path);
> +    }
>      v9fs_path_unlock(s);
> +    v9fs_path_free(&path);
>      if (!err) {
>          total_open_fd++;
>          if (total_open_fd > open_fd_hw) {



-- 
Greg

