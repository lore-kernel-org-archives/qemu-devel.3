Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082C3C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaiY-0008I6-Kz; Wed, 24 Jan 2024 05:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSaiX-0008H6-FY
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:42:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSaiU-0008Fd-I6
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706092965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iU1dyfBrPAP3iQhXRdoJEv76dxvlCfE0rmixQGBJbf8=;
 b=PjU0Ghm5EYRHKa6eaLPX/Pv2TNqCWgOyDyyfYwQ/pvkvGdey/urBv8d5MorFdJNV8r3Q7Q
 Yy98Vr1TngcSErC5aBUjb0nKGQByTKmXgzMKVo6cNNK/o43cIcY9WaurwRoTsb28Qxw6F/
 hSEL35huxpGgTXPZU/uEk0soGHOJ8Sk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-VTIg3_WAOOSrtotyBzEgWg-1; Wed,
 24 Jan 2024 05:42:42 -0500
X-MC-Unique: VTIg3_WAOOSrtotyBzEgWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50E9A2823801;
 Wed, 24 Jan 2024 10:42:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2100551D5;
 Wed, 24 Jan 2024 10:42:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 5/7] util/uri: Remove unused functions uri_resolve() and
 uri_resolve_relative()
Date: Wed, 24 Jan 2024 11:42:29 +0100
Message-ID: <20240124104231.603418-6-thuth@redhat.com>
In-Reply-To: <20240124104231.603418-1-thuth@redhat.com>
References: <20240124104231.603418-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These rather complex functions have never been used since they've been
introduced in 2012, so looks like they are not really useful for QEMU.
And since the static normalize_uri_path() function is also only used by
uri_resolve(), we can remove that function now, too.

Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Message-ID: <20240123182247.432642-3-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/uri.h |   2 -
 util/uri.c         | 689 ---------------------------------------------
 2 files changed, 691 deletions(-)

diff --git a/include/qemu/uri.h b/include/qemu/uri.h
index f0722b75da..899ce852f5 100644
--- a/include/qemu/uri.h
+++ b/include/qemu/uri.h
@@ -72,8 +72,6 @@ typedef struct URI {
 } URI;
 
 URI *uri_new(void);
-char *uri_resolve(const char *URI, const char *base);
-char *uri_resolve_relative(const char *URI, const char *base);
 URI *uri_parse(const char *str);
 URI *uri_parse_raw(const char *str, int raw);
 int uri_parse_into(URI *uri, const char *str);
diff --git a/util/uri.c b/util/uri.c
index fb7823a43c..1891ca6fb3 100644
--- a/util/uri.c
+++ b/util/uri.c
@@ -1355,212 +1355,6 @@ void uri_free(URI *uri)
  *                                                                      *
  ************************************************************************/
 
-/**
- * normalize_uri_path:
- * @path:  pointer to the path string
- *
- * Applies the 5 normalization steps to a path string--that is, RFC 2396
- * Section 5.2, steps 6.c through 6.g.
- *
- * Normalization occurs directly on the string, no new allocation is done
- *
- * Returns 0 or an error code
- */
-static int normalize_uri_path(char *path)
-{
-    char *cur, *out;
-
-    if (path == NULL) {
-        return -1;
-    }
-
-    /* Skip all initial "/" chars.  We want to get to the beginning of the
-     * first non-empty segment.
-     */
-    cur = path;
-    while (cur[0] == '/') {
-        ++cur;
-    }
-    if (cur[0] == '\0') {
-        return 0;
-    }
-
-    /* Keep everything we've seen so far.  */
-    out = cur;
-
-    /*
-     * Analyze each segment in sequence for cases (c) and (d).
-     */
-    while (cur[0] != '\0') {
-        /*
-         * c) All occurrences of "./", where "." is a complete path segment,
-         *    are removed from the buffer string.
-         */
-        if ((cur[0] == '.') && (cur[1] == '/')) {
-            cur += 2;
-            /* '//' normalization should be done at this point too */
-            while (cur[0] == '/') {
-                cur++;
-            }
-            continue;
-        }
-
-        /*
-         * d) If the buffer string ends with "." as a complete path segment,
-         *    that "." is removed.
-         */
-        if ((cur[0] == '.') && (cur[1] == '\0')) {
-            break;
-        }
-
-        /* Otherwise keep the segment.  */
-        while (cur[0] != '/') {
-            if (cur[0] == '\0') {
-                goto done_cd;
-            }
-            (out++)[0] = (cur++)[0];
-        }
-        /* nomalize // */
-        while ((cur[0] == '/') && (cur[1] == '/')) {
-            cur++;
-        }
-
-        (out++)[0] = (cur++)[0];
-    }
-done_cd:
-    out[0] = '\0';
-
-    /* Reset to the beginning of the first segment for the next sequence.  */
-    cur = path;
-    while (cur[0] == '/') {
-        ++cur;
-    }
-    if (cur[0] == '\0') {
-        return 0;
-    }
-
-    /*
-     * Analyze each segment in sequence for cases (e) and (f).
-     *
-     * e) All occurrences of "<segment>/../", where <segment> is a
-     *    complete path segment not equal to "..", are removed from the
-     *    buffer string.  Removal of these path segments is performed
-     *    iteratively, removing the leftmost matching pattern on each
-     *    iteration, until no matching pattern remains.
-     *
-     * f) If the buffer string ends with "<segment>/..", where <segment>
-     *    is a complete path segment not equal to "..", that
-     *    "<segment>/.." is removed.
-     *
-     * To satisfy the "iterative" clause in (e), we need to collapse the
-     * string every time we find something that needs to be removed.  Thus,
-     * we don't need to keep two pointers into the string: we only need a
-     * "current position" pointer.
-     */
-    while (1) {
-        char *segp, *tmp;
-
-        /* At the beginning of each iteration of this loop, "cur" points to
-         * the first character of the segment we want to examine.
-         */
-
-        /* Find the end of the current segment.  */
-        segp = cur;
-        while ((segp[0] != '/') && (segp[0] != '\0')) {
-            ++segp;
-        }
-
-        /* If this is the last segment, we're done (we need at least two
-         * segments to meet the criteria for the (e) and (f) cases).
-         */
-        if (segp[0] == '\0') {
-            break;
-        }
-
-        /* If the first segment is "..", or if the next segment _isn't_ "..",
-         * keep this segment and try the next one.
-         */
-        ++segp;
-        if (((cur[0] == '.') && (cur[1] == '.') && (segp == cur + 3)) ||
-            ((segp[0] != '.') || (segp[1] != '.') ||
-             ((segp[2] != '/') && (segp[2] != '\0')))) {
-            cur = segp;
-            continue;
-        }
-
-        /* If we get here, remove this segment and the next one and back up
-         * to the previous segment (if there is one), to implement the
-         * "iteratively" clause.  It's pretty much impossible to back up
-         * while maintaining two pointers into the buffer, so just compact
-         * the whole buffer now.
-         */
-
-        /* If this is the end of the buffer, we're done.  */
-        if (segp[2] == '\0') {
-            cur[0] = '\0';
-            break;
-        }
-        /* Valgrind complained, strcpy(cur, segp + 3); */
-        /* string will overlap, do not use strcpy */
-        tmp = cur;
-        segp += 3;
-        while ((*tmp++ = *segp++) != 0) {
-            /* No further work */
-        }
-
-        /* If there are no previous segments, then keep going from here.  */
-        segp = cur;
-        while ((segp > path) && ((--segp)[0] == '/')) {
-            /* No further work */
-        }
-        if (segp == path) {
-            continue;
-        }
-
-        /* "segp" is pointing to the end of a previous segment; find it's
-         * start.  We need to back up to the previous segment and start
-         * over with that to handle things like "foo/bar/../..".  If we
-         * don't do this, then on the first pass we'll remove the "bar/..",
-         * but be pointing at the second ".." so we won't realize we can also
-         * remove the "foo/..".
-         */
-        cur = segp;
-        while ((cur > path) && (cur[-1] != '/')) {
-            --cur;
-        }
-    }
-    out[0] = '\0';
-
-    /*
-     * g) If the resulting buffer string still begins with one or more
-     *    complete path segments of "..", then the reference is
-     *    considered to be in error. Implementations may handle this
-     *    error by retaining these components in the resolved path (i.e.,
-     *    treating them as part of the final URI), by removing them from
-     *    the resolved path (i.e., discarding relative levels above the
-     *    root), or by avoiding traversal of the reference.
-     *
-     * We discard them from the final path.
-     */
-    if (path[0] == '/') {
-        cur = path;
-        while ((cur[0] == '/') && (cur[1] == '.') && (cur[2] == '.') &&
-               ((cur[3] == '/') || (cur[3] == '\0'))) {
-            cur += 3;
-        }
-
-        if (cur != path) {
-            out = path;
-            while (cur[0] != '\0') {
-                (out++)[0] = (cur++)[0];
-            }
-            out[0] = 0;
-        }
-    }
-
-    return 0;
-}
-
 /**
  * uri_string_escape:
  * @str:  string to escape
@@ -1631,489 +1425,6 @@ char *uri_string_escape(const char *str, const char *list)
  *                                                                      *
  ************************************************************************/
 
-/**
- * uri_resolve:
- * @URI:  the URI instance found in the document
- * @base:  the base value
- *
- * Computes he final URI of the reference done by checking that
- * the given URI is valid, and building the final URI using the
- * base URI. This is processed according to section 5.2 of the
- * RFC 2396
- *
- * 5.2. Resolving Relative References to Absolute Form
- *
- * Returns a new URI string (to be freed by the caller) or NULL in case
- *         of error.
- */
-char *uri_resolve(const char *uri, const char *base)
-{
-    char *val = NULL;
-    int ret, len, indx, cur, out;
-    URI *ref = NULL;
-    URI *bas = NULL;
-    URI *res = NULL;
-
-    /*
-     * 1) The URI reference is parsed into the potential four components and
-     *    fragment identifier, as described in Section 4.3.
-     *
-     *    NOTE that a completely empty URI is treated by modern browsers
-     *    as a reference to "." rather than as a synonym for the current
-     *    URI.  Should we do that here?
-     */
-    if (uri == NULL) {
-        ret = -1;
-    } else {
-        if (*uri) {
-            ref = uri_new();
-            ret = uri_parse_into(ref, uri);
-        } else {
-            ret = 0;
-        }
-    }
-    if (ret != 0) {
-        goto done;
-    }
-    if ((ref != NULL) && (ref->scheme != NULL)) {
-        /*
-         * The URI is absolute don't modify.
-         */
-        val = g_strdup(uri);
-        goto done;
-    }
-    if (base == NULL) {
-        ret = -1;
-    } else {
-        bas = uri_new();
-        ret = uri_parse_into(bas, base);
-    }
-    if (ret != 0) {
-        if (ref) {
-            val = uri_to_string(ref);
-        }
-        goto done;
-    }
-    if (ref == NULL) {
-        /*
-         * the base fragment must be ignored
-         */
-        g_free(bas->fragment);
-        bas->fragment = NULL;
-        val = uri_to_string(bas);
-        goto done;
-    }
-
-    /*
-     * 2) If the path component is empty and the scheme, authority, and
-     *    query components are undefined, then it is a reference to the
-     *    current document and we are done.  Otherwise, the reference URI's
-     *    query and fragment components are defined as found (or not found)
-     *    within the URI reference and not inherited from the base URI.
-     *
-     *    NOTE that in modern browsers, the parsing differs from the above
-     *    in the following aspect:  the query component is allowed to be
-     *    defined while still treating this as a reference to the current
-     *    document.
-     */
-    res = uri_new();
-    if ((ref->scheme == NULL) && (ref->path == NULL) &&
-        ((ref->authority == NULL) && (ref->server == NULL))) {
-        res->scheme = g_strdup(bas->scheme);
-        if (bas->authority != NULL) {
-            res->authority = g_strdup(bas->authority);
-        } else if (bas->server != NULL) {
-            res->server = g_strdup(bas->server);
-            res->user = g_strdup(bas->user);
-            res->port = bas->port;
-        }
-        res->path = g_strdup(bas->path);
-        if (ref->query != NULL) {
-            res->query = g_strdup(ref->query);
-        } else {
-            res->query = g_strdup(bas->query);
-        }
-        res->fragment = g_strdup(ref->fragment);
-        goto step_7;
-    }
-
-    /*
-     * 3) If the scheme component is defined, indicating that the reference
-     *    starts with a scheme name, then the reference is interpreted as an
-     *    absolute URI and we are done.  Otherwise, the reference URI's
-     *    scheme is inherited from the base URI's scheme component.
-     */
-    if (ref->scheme != NULL) {
-        val = uri_to_string(ref);
-        goto done;
-    }
-    res->scheme = g_strdup(bas->scheme);
-
-    res->query = g_strdup(ref->query);
-    res->fragment = g_strdup(ref->fragment);
-
-    /*
-     * 4) If the authority component is defined, then the reference is a
-     *    network-path and we skip to step 7.  Otherwise, the reference
-     *    URI's authority is inherited from the base URI's authority
-     *    component, which will also be undefined if the URI scheme does not
-     *    use an authority component.
-     */
-    if ((ref->authority != NULL) || (ref->server != NULL)) {
-        if (ref->authority != NULL) {
-            res->authority = g_strdup(ref->authority);
-        } else {
-            res->server = g_strdup(ref->server);
-            res->user = g_strdup(ref->user);
-            res->port = ref->port;
-        }
-        res->path = g_strdup(ref->path);
-        goto step_7;
-    }
-    if (bas->authority != NULL) {
-        res->authority = g_strdup(bas->authority);
-    } else if (bas->server != NULL) {
-        res->server = g_strdup(bas->server);
-        res->user = g_strdup(bas->user);
-        res->port = bas->port;
-    }
-
-    /*
-     * 5) If the path component begins with a slash character ("/"), then
-     *    the reference is an absolute-path and we skip to step 7.
-     */
-    if ((ref->path != NULL) && (ref->path[0] == '/')) {
-        res->path = g_strdup(ref->path);
-        goto step_7;
-    }
-
-    /*
-     * 6) If this step is reached, then we are resolving a relative-path
-     *    reference.  The relative path needs to be merged with the base
-     *    URI's path.  Although there are many ways to do this, we will
-     *    describe a simple method using a separate string buffer.
-     *
-     * Allocate a buffer large enough for the result string.
-     */
-    len = 2; /* extra / and 0 */
-    if (ref->path != NULL) {
-        len += strlen(ref->path);
-    }
-    if (bas->path != NULL) {
-        len += strlen(bas->path);
-    }
-    res->path = g_malloc(len);
-    res->path[0] = 0;
-
-    /*
-     * a) All but the last segment of the base URI's path component is
-     *    copied to the buffer.  In other words, any characters after the
-     *    last (right-most) slash character, if any, are excluded.
-     */
-    cur = 0;
-    out = 0;
-    if (bas->path != NULL) {
-        while (bas->path[cur] != 0) {
-            while ((bas->path[cur] != 0) && (bas->path[cur] != '/')) {
-                cur++;
-            }
-            if (bas->path[cur] == 0) {
-                break;
-            }
-
-            cur++;
-            while (out < cur) {
-                res->path[out] = bas->path[out];
-                out++;
-            }
-        }
-    }
-    res->path[out] = 0;
-
-    /*
-     * b) The reference's path component is appended to the buffer
-     *    string.
-     */
-    if (ref->path != NULL && ref->path[0] != 0) {
-        indx = 0;
-        /*
-         * Ensure the path includes a '/'
-         */
-        if ((out == 0) && (bas->server != NULL)) {
-            res->path[out++] = '/';
-        }
-        while (ref->path[indx] != 0) {
-            res->path[out++] = ref->path[indx++];
-        }
-    }
-    res->path[out] = 0;
-
-    /*
-     * Steps c) to h) are really path normalization steps
-     */
-    normalize_uri_path(res->path);
-
-step_7:
-
-    /*
-     * 7) The resulting URI components, including any inherited from the
-     *    base URI, are recombined to give the absolute form of the URI
-     *    reference.
-     */
-    val = uri_to_string(res);
-
-done:
-    uri_free(ref);
-    uri_free(bas);
-    uri_free(res);
-    return val;
-}
-
-/**
- * uri_resolve_relative:
- * @URI:  the URI reference under consideration
- * @base:  the base value
- *
- * Expresses the URI of the reference in terms relative to the
- * base.  Some examples of this operation include:
- *     base = "http://site1.com/docs/book1.html"
- *        URI input                        URI returned
- *     docs/pic1.gif                    pic1.gif
- *     docs/img/pic1.gif                img/pic1.gif
- *     img/pic1.gif                     ../img/pic1.gif
- *     http://site1.com/docs/pic1.gif   pic1.gif
- *     http://site2.com/docs/pic1.gif   http://site2.com/docs/pic1.gif
- *
- *     base = "docs/book1.html"
- *        URI input                        URI returned
- *     docs/pic1.gif                    pic1.gif
- *     docs/img/pic1.gif                img/pic1.gif
- *     img/pic1.gif                     ../img/pic1.gif
- *     http://site1.com/docs/pic1.gif   http://site1.com/docs/pic1.gif
- *
- *
- * Note: if the URI reference is really weird or complicated, it may be
- *       worthwhile to first convert it into a "nice" one by calling
- *       uri_resolve (using 'base') before calling this routine,
- *       since this routine (for reasonable efficiency) assumes URI has
- *       already been through some validation.
- *
- * Returns a new URI string (to be freed by the caller) or NULL in case
- * error.
- */
-char *uri_resolve_relative(const char *uri, const char *base)
-{
-    char *val = NULL;
-    int ret;
-    int ix;
-    int pos = 0;
-    int nbslash = 0;
-    int len;
-    URI *ref = NULL;
-    URI *bas = NULL;
-    char *bptr, *uptr, *vptr;
-    int remove_path = 0;
-
-    if ((uri == NULL) || (*uri == 0)) {
-        return NULL;
-    }
-
-    /*
-     * First parse URI into a standard form
-     */
-    ref = uri_new();
-    /* If URI not already in "relative" form */
-    if (uri[0] != '.') {
-        ret = uri_parse_into(ref, uri);
-        if (ret != 0) {
-            goto done; /* Error in URI, return NULL */
-        }
-    } else {
-        ref->path = g_strdup(uri);
-    }
-
-    /*
-     * Next parse base into the same standard form
-     */
-    if ((base == NULL) || (*base == 0)) {
-        val = g_strdup(uri);
-        goto done;
-    }
-    bas = uri_new();
-    if (base[0] != '.') {
-        ret = uri_parse_into(bas, base);
-        if (ret != 0) {
-            goto done; /* Error in base, return NULL */
-        }
-    } else {
-        bas->path = g_strdup(base);
-    }
-
-    /*
-     * If the scheme / server on the URI differs from the base,
-     * just return the URI
-     */
-    if ((ref->scheme != NULL) &&
-        ((bas->scheme == NULL) || (strcmp(bas->scheme, ref->scheme)) ||
-         (strcmp(bas->server, ref->server)))) {
-        val = g_strdup(uri);
-        goto done;
-    }
-    if (bas->path == ref->path ||
-        (bas->path && ref->path && !strcmp(bas->path, ref->path))) {
-        val = g_strdup("");
-        goto done;
-    }
-    if (bas->path == NULL) {
-        val = g_strdup(ref->path);
-        goto done;
-    }
-    if (ref->path == NULL) {
-        ref->path = (char *)"/";
-        remove_path = 1;
-    }
-
-    /*
-     * At this point (at last!) we can compare the two paths
-     *
-     * First we take care of the special case where either of the
-     * two path components may be missing (bug 316224)
-     */
-    if (bas->path == NULL) {
-        if (ref->path != NULL) {
-            uptr = ref->path;
-            if (*uptr == '/') {
-                uptr++;
-            }
-            /* exception characters from uri_to_string */
-            val = uri_string_escape(uptr, "/;&=+$,");
-        }
-        goto done;
-    }
-    bptr = bas->path;
-    if (ref->path == NULL) {
-        for (ix = 0; bptr[ix] != 0; ix++) {
-            if (bptr[ix] == '/') {
-                nbslash++;
-            }
-        }
-        uptr = NULL;
-        len = 1; /* this is for a string terminator only */
-    } else {
-        /*
-         * Next we compare the two strings and find where they first differ
-         */
-        if ((ref->path[pos] == '.') && (ref->path[pos + 1] == '/')) {
-            pos += 2;
-        }
-        if ((*bptr == '.') && (bptr[1] == '/')) {
-            bptr += 2;
-        } else if ((*bptr == '/') && (ref->path[pos] != '/')) {
-            bptr++;
-        }
-        while ((bptr[pos] == ref->path[pos]) && (bptr[pos] != 0)) {
-            pos++;
-        }
-
-        if (bptr[pos] == ref->path[pos]) {
-            val = g_strdup("");
-            goto done; /* (I can't imagine why anyone would do this) */
-        }
-
-        /*
-         * In URI, "back up" to the last '/' encountered.  This will be the
-         * beginning of the "unique" suffix of URI
-         */
-        ix = pos;
-        if ((ref->path[ix] == '/') && (ix > 0)) {
-            ix--;
-        } else if ((ref->path[ix] == 0) && (ix > 1)
-                && (ref->path[ix - 1] == '/')) {
-            ix -= 2;
-        }
-        for (; ix > 0; ix--) {
-            if (ref->path[ix] == '/') {
-                break;
-            }
-        }
-        if (ix == 0) {
-            uptr = ref->path;
-        } else {
-            ix++;
-            uptr = &ref->path[ix];
-        }
-
-        /*
-         * In base, count the number of '/' from the differing point
-         */
-        if (bptr[pos] != ref->path[pos]) { /* check for trivial URI == base */
-            for (; bptr[ix] != 0; ix++) {
-                if (bptr[ix] == '/') {
-                    nbslash++;
-                }
-            }
-        }
-        len = strlen(uptr) + 1;
-    }
-
-    if (nbslash == 0) {
-        if (uptr != NULL) {
-            /* exception characters from uri_to_string */
-            val = uri_string_escape(uptr, "/;&=+$,");
-        }
-        goto done;
-    }
-
-    /*
-     * Allocate just enough space for the returned string -
-     * length of the remainder of the URI, plus enough space
-     * for the "../" groups, plus one for the terminator
-     */
-    val = g_malloc(len + 3 * nbslash);
-    vptr = val;
-    /*
-     * Put in as many "../" as needed
-     */
-    for (; nbslash > 0; nbslash--) {
-        *vptr++ = '.';
-        *vptr++ = '.';
-        *vptr++ = '/';
-    }
-    /*
-     * Finish up with the end of the URI
-     */
-    if (uptr != NULL) {
-        if ((vptr > val) && (len > 0) && (uptr[0] == '/') &&
-            (vptr[-1] == '/')) {
-            memcpy(vptr, uptr + 1, len - 1);
-            vptr[len - 2] = 0;
-        } else {
-            memcpy(vptr, uptr, len);
-            vptr[len - 1] = 0;
-        }
-    } else {
-        vptr[len - 1] = 0;
-    }
-
-    /* escape the freshly-built path */
-    vptr = val;
-    /* exception characters from uri_to_string */
-    val = uri_string_escape(vptr, "/;&=+$,");
-    g_free(vptr);
-
-done:
-    /*
-     * Free the working variables
-     */
-    if (remove_path != 0) {
-        ref->path = NULL;
-    }
-    uri_free(ref);
-    uri_free(bas);
-
-    return val;
-}
-
 /*
  * Utility functions to help parse and assemble query strings.
  */
-- 
2.43.0


